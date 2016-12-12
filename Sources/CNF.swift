
public struct CNF<Literal>: CustomStringConvertible where Literal: SignedInteger {
    public typealias Clause = [Literal]
    
    public var maxVar: Literal
    public var matrix: [Clause]
    
    public init() {
        maxVar = 0
        matrix = []
    }
    
    public mutating func add(clause: Clause) {
        matrix.append(clause)
        for variable in clause.map(abs) {
            if variable > maxVar {
                maxVar = variable
            }
        }
    }
    
    public var description: String {
        var dimacs = "p cnf \(maxVar) \(matrix.count)\n"
        for clause in matrix {
            dimacs += clause.map(String.init(describing:)).joined(separator: " ") + " 0\n"
        }
        return dimacs
    }
}
