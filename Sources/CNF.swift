
public struct CNF<Literal> {
    public typealias Clause = [Literal]
    public var matrix: [Clause]
    
    init() {
        matrix = []
    }
    
    mutating func add(clause: Clause) {
        matrix.append(clause)
    }
}
