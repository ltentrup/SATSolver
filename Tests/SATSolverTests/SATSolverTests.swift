import XCTest
@testable import SATSolver

class SATSolverTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SATSolver().text, "Hello, World!")
    }


    static var allTests : [(String, (SATSolverTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
