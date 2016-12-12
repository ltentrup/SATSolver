import XCTest
@testable import SATSolver

class SATSolverTests: XCTestCase {
    func testCNFSimple() {
        var cnf = CNF<Int>()
        cnf.add(clause: [1, 2, 3])
        cnf.add(clause: [-1, -2])
        XCTAssertEqual(cnf.maxVar, 3)
        XCTAssertEqual(cnf.matrix.count, 2)
    }


    static var allTests : [(String, (SATSolverTests) -> () throws -> Void)] {
        return [
            ("testCNFSimple", testCNFSimple),
        ]
    }
}
