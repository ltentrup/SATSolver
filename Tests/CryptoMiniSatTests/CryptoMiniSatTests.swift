import XCTest
@testable import CryptoMiniSat

class CryptoMiniSatTests: XCTestCase {
    func testIncrementalSolving() {
        let cmsat = CryptoMiniSat()
        
        let a = cmsat.new()
        let b = cmsat.new()
        XCTAssertNotEqual(a, b)
        XCTAssertEqual(cmsat.maxVar, 2)
        
        cmsat.add(clause: [a, b])
        cmsat.add(clause: [-b])
        XCTAssertEqual(cmsat.solve(), .satisfiable)
        XCTAssertEqual(cmsat.value(of: a), .positive)
        XCTAssertEqual(cmsat.value(of: b), .negative)
        
        cmsat.assume(literal: b)
        XCTAssertEqual(cmsat.solve(), .unsatisfiable)
        XCTAssertFalse(cmsat.failed(literal: a))
        XCTAssertTrue(cmsat.failed(literal: b))
        
        XCTAssertEqual(cmsat.solve(), .satisfiable)
    }


    static var allTests : [(String, (CryptoMiniSatTests) -> () throws -> Void)] {
        return [
            ("testIncrementalSolving", testIncrementalSolving),
        ]
    }
}
