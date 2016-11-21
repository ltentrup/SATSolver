
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
    
    func new() -> Literal
    func add(literal: Literal)
    func assume(literal: Literal)
    func solve() -> SATSolverResult
    func value(of literal: Literal) -> SATSolverLiteralValue
    func failed(literal: Literal) -> Bool
}

public extension SATSolver where Literal: Integer {
    func add(clause: [Literal]) {
        clause.forEach({ add(literal: $0) })
        add(literal: 0)
    }
}