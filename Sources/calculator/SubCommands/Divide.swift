import Foundation
import ArgumentParser

struct Divide: ParsableCommand {
    
    static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Return the division of given numbers")
    
    @Argument(help: "Frist number")
    private var first: Double
    
    @Argument(help: "Second number")
    private var second: Double
    
    func validate() throws {
        if second == .zero {
            throw ValidationError("Cannot divide with 0!")
        }
    }
    
    func run() throws {
        print(first / second)
    }
}
