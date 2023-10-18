// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftCrossUI
import GtkBackend

class RandomNumberGeneratorState: Observable {
    @Observed var minNum = 0
    @Observed var maxNum = 100
    @Observed var randomNumber = 0
    @Observed var minNumberInput = ""
    @Observed var maxNumberInput = ""
}

@main
struct RNGTool_Plus_App: App {
    typealias Backend = GtkBackend

    let identifier = "com.NCX-Programming.RNGTool-Plus"

    let state = RandomNumberGeneratorState()

    let windowProperties = WindowProperties(
        title: "RNGTool Plus",
        defaultSize: .init(500, 0)
    )

    var body: some ViewContent {
        VStack {
            Text("Number: \(state.randomNumber)")
            Button("Generate") {
                state.minNum = Int(state.minNumberInput) ?? 0
                state.maxNum = Int(state.maxNumberInput) ?? 100
                if (state.maxNum <= state.minNum) {
                    state.minNumberInput = ""
                    state.minNum = 0
                }
                state.randomNumber = Int.random(in: Int(state.minNum)...Int(state.maxNum))
            }
            Text("Minimum Number (Default: 0)")
            TextField("Enter a number", state.$minNumberInput)
            Text("Maximum Number (Default: 100)")
            TextField("Enter a number", state.$maxNumberInput)
        }
        .padding(10)
    }
}
