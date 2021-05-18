import XCTest
import class Foundation.Bundle

final class CalculatorTests: XCTestCase {
    
    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("Couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }
    
    
    func testSum() throws {
        try performOperation(.sum)
    }
    
    func testSubtraction() throws {
        try performOperation(.subtract)
    }
    
    func testMultiplication() throws {
        try performOperation(.multiply)
    }
    
    func testDibision() throws {
        try performOperation(.divide)
    }
    
    func testDibisionOnZero() throws {
        XCTAssertThrowsError(try performOperation(.divide, optionalSecondArgument: .zero))
    }
    
    private func performOperation(_ operation: OperationType, optionalSecondArgument: Double? = nil) throws {
        guard #available(macOS 10.13, *) else {
            return
        }

        #if !targetEnvironment(macCatalyst)

        let fooBinary = productsDirectory
            .appendingPathComponent("calculator")
        
        let numbers = operation.params
        let firstArgument = numbers.first!
        let secondArgument = optionalSecondArgument ?? numbers.last!

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe
        process.arguments = [operation.rawValue, String(firstArgument), String(secondArgument)]

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
        let expectedResult = try operation.result(firstArgument, secondArgument)

        XCTAssertEqual(output, "\(expectedResult)\n")
        #endif
    }
}

extension CalculatorTests {
    
    struct ArgumentError: Error { }
    
    enum OperationType: String {
        case sum
        case divide
        case subtract
        case multiply
        
        var params: [Double] {
            [Double.random(in: 1...100), Double.random(in: 1...100)]
        }
        
        func result(_ first: Double, _ second: Double) throws -> Double  {
            switch self {
            case .sum:
                return first + second
            
            case .subtract:
                return first - second
            
            case .divide:
                guard second != .zero else {
                    throw ArgumentError()
                }
                return first / second
                
            case .multiply:
                return first * second
            }
        }
    }
}
