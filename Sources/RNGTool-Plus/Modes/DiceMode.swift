/*  RNGTool Plus "DiceMode.swift"
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

class DiceModeState: Observable {
    @Observed var numOfDice: Int? = 1
    @Observed var randomNumbers: [Int] = []
    @Observed var randomNumberStr: String = "Click Roll to begin"
    @Observed var diceImages: [String] = ["Die1.svg", "Die1.svg", "Die1.svg", "Die1.svg", "Die1.svg", "Die1.svg"]
}

struct DiceMode: View {

    var state = DiceModeState()

    let diceLight: [String] = ["Die1.svg", "Die2.svg", "Die3.svg", "Die4.svg", "Die5.svg", "Die6.svg"]
    let diceDark: [String] = ["Die1-dark.svg", "Die2-dark.svg", "Die3-dark.svg", "Die4-dark.svg", "Die5-dark.svg", "Die6-dark.svg"]

    var body: some View {
        VStack() {
            HStack() {
                ForEach(0..<state.numOfDice!) { index in
                    Image(Bundle.module.bundleURL.appendingPathComponent(state.diceImages[index]).path)
                        .frame(minWidth: 65, minHeight: 65)
                }
            }
            Text(state.randomNumberStr)
            HStack() {
                Text("Number of dice:")
                Picker(of: [1,2,3,4,5,6], selection: state.$numOfDice)
                Spacer()
            }
            HStack() {
                Button("Roll") {
                    state.randomNumbers.removeAll()
                    for _ in 1...state.numOfDice! {
                        state.randomNumbers.append(Int.random(in: 1...6))
                    }
                    for n in 0..<state.numOfDice! {
                        state.diceImages[n] = diceLight[state.randomNumbers[n]-1]
                    }
                    state.randomNumberStr = "Your random number(s): \(state.randomNumbers)"
                    state.randomNumberStr = state.randomNumberStr.replacingOccurrences(of: "[", with: "")
                    state.randomNumberStr = state.randomNumberStr.replacingOccurrences(of: "]", with: "")
                }
                Button("Reset") {
                    state.numOfDice = 1
                    state.randomNumbers.removeAll()
                    for n in 0..<6 {
                        state.diceImages[n] = diceLight[0]
                    }
                    state.randomNumberStr = "Click Roll to begin"
                }
                Spacer()
            }
        }
    }
}
