
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
    
    public mutating func add(clause: Clause) {
        _matrix.append(clause)
        for variable in clause.map(abs) {
            if variable > maxVar {
                maxVar = variable
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
