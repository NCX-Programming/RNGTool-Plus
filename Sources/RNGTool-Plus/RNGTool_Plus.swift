/*  RNGTool Plus "RNGTool_Plus.swift"
MIT License

Copyright (c) 2023 NCX Programming

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE */

import SwiftCrossUI
import GtkBackend

class NumberModeState: Observable {
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

    let state = NumberModeState()

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
