/*  RNGTool Plus "MarbleMode.swift"
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

import Foundation
import SwiftCrossUI
import GtkBackend

class MarbleModeState: Observable {
    @Observed var numOfMarbles: Int? = 1
    @Observed var randomNumbers: [Int] = []
    @Observed var randomLettersStr: String = "Click Roll to begin"
    @Observed var randomLetters: [String] = ["A", "A", "A", "A", "A", "A"]
}

struct MarbleMode: View {

    var state = MarbleModeState()

    let letterList: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    var body: some View {
        VStack() {
            HStack() {
                ForEach(0..<state.numOfMarbles!) { index in
                    Text(state.randomLetters[index])
                }
            }
            Text(state.randomLettersStr)
                .padding(.top, 20)
            HStack() {
                Text("Number of marbles:")
                Picker(of: [1,2,3,4,5,6], selection: state.$numOfMarbles)
                Spacer()
            }
            HStack() {
                Button("Roll") {
                    state.randomNumbers.removeAll()
                    for _ in 1...state.numOfMarbles! {
                        state.randomNumbers.append(Int.random(in: 1...26))
                    }
                    for n in 0..<state.numOfMarbles! {
                        state.randomLetters[n] = letterList[state.randomNumbers[n]-1]
                    }
                    state.randomLettersStr = "Your random letters(s): \(state.randomLetters)"
                    state.randomLettersStr = state.randomLettersStr.replacingOccurrences(of: "[", with: "")
                    state.randomLettersStr = state.randomLettersStr.replacingOccurrences(of: "]", with: "")
                    state.randomLettersStr = state.randomLettersStr.replacingOccurrences(of: "\"", with: "")
                }
                Button("Reset") {
                    state.numOfMarbles = 1
                    state.randomNumbers.removeAll()
                    for n in 0..<6 {
                        state.randomLetters[n] = letterList[0]
                    }
                    state.randomLettersStr = "Click Roll to begin"
                }
                Spacer()
            }
        }
    }
}
