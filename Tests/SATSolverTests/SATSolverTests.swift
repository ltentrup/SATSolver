import XCTest
@testable import SATSolver

class SATSolverTests: XCTestCase {
    func testCNFSimple() {
        var cnf = CNF<Int>()
        cnf.add(clause: [1, 2, 3])
        cnf.add(clause: [-1, -2])
        XCTAssertEqual(cnf.maxVar, 3)
        XCTAssertEqual(cnf.numClauses, 2)
    }
    
    func testCNFclauseSubsumption() {
        let cnf = CNF<Int>()
        let clause1 = [3, 6, 9]
        let clause2 = [1, 3, 4, 6, 8, 10]
        let clause3 = [1, 3, 4, 6, 8, 9, 10]
        let clause4 = [1, 2]
        
        XCTAssertFalse(cnf.clauseSubsumption(base: clause1, other: clause2))
        XCTAssertTrue(cnf.clauseSubsumption(base: clause1, other: clause3))
        XCTAssertFalse(cnf.clauseSubsumption(base: clause1, other: clause4))
    }
    
    func testCNFSimplification() {
        var cnf = CNF<Int>()
        cnf.add(clause: [1, 2, 3])
        cnf.add(clause: [-1, -2])
        cnf.add(clause: [1, 3], simplify: true)
        XCTAssertEqual(cnf.maxVar, 3)
        XCTAssertEqual(cnf.numClauses, 2)
    }

    static var allTests : [(String, (SATSolverTests) -> () throws -> Void)] {
        return [
            ("testCNFSimple", testCNFSimple),
            ("testCNFclauseSubsumption", testCNFclauseSubsumption),
            ("testCNFSimplification", testCNFSimplification),
        ]
    }
}
