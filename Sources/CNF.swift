
public struct CNF<Literal> {
    public typealias Clause = [Literal]
    public var matrix: [Clause]
    
    mutating func add(clause: Clause) {
        matrix.append(clause)
    }
}
