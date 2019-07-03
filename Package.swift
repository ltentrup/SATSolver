// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SATSolver",
    products: [
        .library(name: "SATSolver", targets: ["SATSolver"]),
        
        // PicoSAT
        .library(name: "PicoSAT", targets: ["PicoSAT"]),
        .library(name: "CPicoSAT", targets: ["CPicoSAT"]),
        
        // MiniSat
        .library(name: "MiniSat", targets: ["MiniSat"]),
        .library(name: "CMiniSat", targets: ["CMiniSat"]),
        
        // CryptoMiniSat
        .library(name: "CryptoMiniSat", targets: ["CryptoMiniSat"])
    ],
    targets: [
        .target(name: "SATSolver"),
        .testTarget(name: "SATSolverTests", dependencies: ["SATSolver"]),
        
        // PicoSAT
        .target(name: "PicoSAT", dependencies: ["CPicoSAT", "SATSolver"]),
        .testTarget(name: "PicoSATTests", dependencies: ["PicoSAT"]),
        .target(name: "CPicoSAT"),
        .testTarget(name: "CPicoSATTests", dependencies: ["CPicoSAT"]),
        
        // MiniSat
        .target(name: "MiniSat", dependencies: ["CMiniSat", "SATSolver"]),
        .testTarget(name: "MiniSatTests", dependencies: ["MiniSat"]),
        .target(name: "CMiniSat", dependencies: ["CppMiniSat"]),
        .testTarget(name: "CMiniSatTests", dependencies: ["CMiniSat"]),
        .target(name: "CppMiniSat"),
        
        // MiniSat
        .target(name: "CryptoMiniSat", dependencies: ["CCryptoMiniSat", "SATSolver"]),
        .testTarget(name: "CryptoMiniSatTests", dependencies: ["CryptoMiniSat"]),
        .target(name: "CCryptoMiniSat", dependencies: ["CppCryptoMiniSat"]),
        .testTarget(name: "CCryptoMiniSatTests", dependencies: ["CCryptoMiniSat"]),
        .target(name: "CppCryptoMiniSat"),
    ],
    cxxLanguageStandard: .cxx11
)
