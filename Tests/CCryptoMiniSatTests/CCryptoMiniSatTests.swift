import XCTest
@testable import CCryptoMiniSat

class CCryptoMiniSatTests: XCTestCase {
    func testIncrementalSolving() {
        let cmsat = cryptominisat_init()
        
        let a = cryptominisat_new(cmsat)
        let b = cryptominisat_new(cmsat)
        
        XCTAssertNotEqual(a, b)
        XCTAssertEqual(cryptominisat_max_var(cmsat), 2)
        
        cryptominisat_add(cmsat, a)
        cryptominisat_add(cmsat, b)
        cryptominisat_add(cmsat, 0)
        
        cryptominisat_add(cmsat, -b)
        cryptominisat_add(cmsat, 0)
        
        XCTAssertTrue(cryptominisat_solve(cmsat))
        XCTAssertTrue(cryptominisat_value(cmsat, a) > 0)
        XCTAssertTrue(cryptominisat_value(cmsat, b) < 0)
        
        cryptominisat_assume(cmsat, b)
        
        XCTAssertFalse(cryptominisat_solve(cmsat))
        XCTAssertFalse(cryptominisat_failed(cmsat, a))
        XCTAssertTrue(cryptominisat_failed(cmsat, b))
        
        XCTAssertTrue(cryptominisat_solve(cmsat))
    }


    static var allTests : [(String, (CCryptoMiniSatTests) -> () throws -> Void)] {
        return [
            ("testIncrementalSolving", testIncrementalSolving),
        ]
    }
}
