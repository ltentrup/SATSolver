
public struct CNF<Literal>: CustomStringConvertible, Sequence where Literal: SignedInteger {
    public typealias Clause = [Literal]
    public typealias Iterator = IndexingIterator<[[Literal]]>
    
    var _matrix: [Clause]
    public var maxVar: Literal
    
    @available(*, deprecated)
    public var matrix: [Clause] {
        return _matrix
    }
    
    public var numClauses: Int {
        return _matrix.count
    }
    
    public init() {
        maxVar = 0
        _matrix = []
    }
    
    public mutating func new() -> Literal {
        maxVar = maxVar + 1
        return maxVar
    }
    
    public mutating func add(clause insert: Clause, simplify: Bool = false) {
        let clause = insert.sorted()
        if simplify {
            _matrix = _matrix.filter { !clauseSubsumption(base: clause, other: $0) }
        }
        _matrix.append(clause)
        for variable in clause.map(abs) {
            if variable > maxVar {
                maxVar = variable
            }
        }
    }
    
    /**
     * Checks if clause `base` subsumes clause `other`.
     * This is the case if all literals in `base` are also contained in `other`.
     */
    func clauseSubsumption(base clause: Clause, other: Clause) -> Bool {
        // precondition: self and other are ordered
        var j = 0
        for i in 0..<clause.count {
            if j >= other.count {
                return false
            }
            while j < other.count {
                
                let element = clause[i]
                let match = other[j]
                
                if match < element {
                    j += 1
                } else if match == element {
                    j += 1
                    break
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    public mutating func compress<A>(solver: A) where A: SATSolver, A.Literal == Literal {
        if numClauses == 0 {
            return
        }
        
        var matrix = _matrix.sorted(by: { $0.count > $1.count })
        _matrix.removeAll(keepingCapacity: true)
        let firstClause = matrix.popLast()!
        solver.add(clause: firstClause)
        add(clause: firstClause, simplify: false)
        
        while matrix.count > 0 {
            let clause = matrix.popLast()!
            clause.map(-).forEach({ solver.assume(literal: $0) })
            if solver.solve() == .satisfiable {
                solver.add(clause: clause)
                add(clause: clause, simplify: false)
            }
        }
    }
    
    // Conforming to CustomStringConvertible
    public var description: String {
        var dimacs = "p cnf \(maxVar) \(numClauses)\n"
        for clause in self {
            dimacs += clause.map(String.init(describing:)).joined(separator: " ") + " 0\n"
        }
        return dimacs
    }
    
    // Conforming to Sequence
    public func makeIterator() -> Iterator {
        return _matrix.makeIterator()
    }
}

