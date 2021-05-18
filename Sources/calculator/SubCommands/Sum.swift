import Foundation
import ArgumentParser

struct Sum: ParsableCommand {
    
    static let configuration: CommandConfiguration = CommandConfiguration(abstract: "Return the sum of given numbers")
    
    @Argument(help: "Numbers to sum")
    private var numbers: [Double]
    
    func run() throws {
        print(numbers.reduce(0, +))
    }
}
