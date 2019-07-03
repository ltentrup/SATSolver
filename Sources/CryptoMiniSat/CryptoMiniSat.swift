import CCryptoMiniSat
import SATSolver

public class CryptoMiniSat: SATSolver {
    public typealias Literal = Int32
    
    let cmsat: OpaquePointer
    
    public required init() {
        cmsat = cryptominisat_init()
    }
    
    deinit {
        cryptominisat_free(cmsat)
    }
    
    public var maxVar: Literal {
        return cryptominisat_max_var(cmsat)
    }
    
    public func new() -> Literal {
        return cryptominisat_new(cmsat)
    }

    public func add(literal: Literal) {
        cryptominisat_add(cmsat, literal)
    }
    
    public func assume(literal: Literal) {
        cryptominisat_assume(cmsat, literal)
    }
    
    public func solve() -> SATSolverResult {
        if cryptominisat_solve(cmsat) {
            return .satisfiable
        } else {
            return .unsatisfiable
        }
    }
    
    public func value(of literal: Literal) -> SATSolverLiteralValue {
        let value = cryptominisat_value(cmsat, literal)
        if value < 0 {
            return .negative
        } else if value > 0 {
            return .positive
        } else {
            return .unassigned
        }
    }
    
    public func failed(literal: Literal) -> Bool {
        return cryptominisat_failed(cmsat, literal)
    }
}
