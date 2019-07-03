import XCTest
@testable import CPicoSAT

class CPicoSATTests: XCTestCase {
    func testIncrementalSolving() {
        let picosat = picosat_init()
        
        picosat_add(picosat, 1)
        picosat_add(picosat, 2)
        picosat_add(picosat, 0)
        
        picosat_add(picosat, -2)
        picosat_add(picosat, 0)
        
        XCTAssertEqual(picosat_sat(picosat, -1), PICOSAT_SATISFIABLE)
        XCTAssertTrue(picosat_deref(picosat, 1) > 0)
        XCTAssertTrue(picosat_deref(picosat, 2) < 0)
        
        picosat_assume(picosat, 2)
        
        XCTAssertEqual(picosat_sat(picosat, -1), PICOSAT_UNSATISFIABLE)
        XCTAssertTrue(picosat_failed_assumption(picosat, 1) == 0)
        XCTAssertTrue(picosat_failed_assumption(picosat, 2) != 0)
        
        XCTAssertEqual(picosat_sat(picosat, -1), PICOSAT_SATISFIABLE)
    }


    static var allTests : [(String, (CPicoSATTests) -> () throws -> Void)] {
        return [
            ("testIncrementalSolving", testIncrementalSolving),
        ]
    }
}
