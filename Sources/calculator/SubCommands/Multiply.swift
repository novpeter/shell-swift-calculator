import Foundation
import ArgumentParser

struct Multiply: ParsableCommand {
    
    static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Return the multiplication of given numbers")
    
    @Argument(help: "Numbers to multiply")
    private var numbers: [Double]
    
    func run() throws {
        print(numbers.reduce(1, *))
    }
}
