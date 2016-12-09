
public struct CNF<Literal> {
    public typealias Clause = [Literal]
    public var matrix: [Clause]
    
    public init() {
        matrix = []
    }
    
    public mutating func add(clause: Clause) {
        matrix.append(clause)
    }
}
