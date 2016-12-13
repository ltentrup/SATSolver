
public enum SATSolverResult {
    case satisfiable
    case unsatisfiable
}

public enum SATSolverLiteralValue {
    case positive
    case negative
    case unassigned
}

public protocol SATSolver {
    associatedtype Literal
    
    var maxVar: Literal { get }
    
    init()
    func new() -> Literal
    func add(literal: Literal)
    func assume(literal: Literal)
    func solve() -> SATSolverResult
    func value(of literal: Literal) -> SATSolverLiteralValue
    func failed(literal: Literal) -> Bool
}

public extension SATSolver where Literal: SignedInteger {
    init(matrix: CNF<Literal>) {
        self.init()
        add(matrix: matrix)
    }
    
    func add(clause: [Literal]) {
        clause.forEach({ add(literal: $0) })
        add(literal: 0)
    }
    
    func add(matrix: CNF<Literal>) {
        while matrix.maxVar > maxVar {
            let _ = new()
        }
        for clause in matrix {
            add(clause: clause)
        }
    }
    
    func addNegated(matrix: CNF<Literal>) {
        var auxVars: [Literal] = []
        for clause in matrix {
            let auxVar = new()
            auxVars.append(auxVar)
            
            for literal in clause {
                add(clause: [-auxVar, -literal])
            }
        }
        add(clause: auxVars)
    }
}
