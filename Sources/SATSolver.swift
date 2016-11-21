
public enum SATSolverResult {
    case satisfiable
    case unsatisfiable
}

public protocol SATSolver {
    func add(literal: Int)
    func assume(literal: Int)
    func solve() -> SATSolverResult
    func value(of literal: Int) -> Int
    func failed(literal: Int) -> Bool
}

public extension SATSolver {
    func add(clause: [Int]) {
        clause.forEach({ add(literal: $0) })
        add(literal: 0)
    }
}