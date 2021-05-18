import Foundation
import ArgumentParser

struct Calculator: ParsableCommand {

    static var configuration = CommandConfiguration(abstract: "Basic command line calculator to compute basic math operations",
                                                    subcommands: [Sum.self, Subtract.self, Multiply.self, Divide.self])
}

Calculator.main()
