/*  RNGTool Plus "NumberMode.swift"
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

struct NumberMode: View {

    var state = NumberModeState()

    var body: some ViewContent {
        VStack {
            Text("Number: \(state.randomNumber)")
            Button("Generate") {
                state.maxNum = Int(state.maxNumberInput) ?? 100
                state.minNum = Int(state.minNumberInput) ?? 0
                if (state.maxNum <= state.minNum) {
                    state.minNumberInput = ""
                    state.minNum = 0
                }
                state.randomNumber = Int.random(in: Int(state.minNum)...Int(state.maxNum))
            }
            Text("Maximum Number")
            Text("Default: 100, Current: " + state.maxNumberInput)
            TextField("Enter a number", state.$maxNumberInput)
            Text("Minimum Number")
            Text("Default: 0, Current: " + state.minNumberInput)
            TextField("Enter a number", state.$minNumberInput)
            HStack {
                Button("Reset") {
                    state.maxNum = 100
                    state.minNum = 0
                    state.maxNumberInput = ""
                    state.minNumberInput = ""
                    state.randomNumber = 0
                }
                Spacer()
            }
        }
    }
}