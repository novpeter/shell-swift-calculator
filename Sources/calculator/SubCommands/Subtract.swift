import Foundation
import ArgumentParser

struct Subtract: ParsableCommand {
    
    static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Return the subtraction of two numbers")
    
    @Argument(help: "Frist number")
    private var first: Double
    
    @Argument(help: "Second number")
    private var second: Double
    
    func run() throws {
        print(first - second)
    }
}
