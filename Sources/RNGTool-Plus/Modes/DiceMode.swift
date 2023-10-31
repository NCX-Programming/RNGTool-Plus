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
    @Observed var randomNumbers: [Int] = []
    @Observed var diceImages: [String] = ["Die1.svg", "Die2.svg", "Die3.svg", "Die4.svg", "Die5.svg", "Die6.svg"]
}

struct DiceMode: View {

    var state = DiceModeState()

    var body: some ViewContent {
        VStack() {
            HStack() {
                Image(Bundle.module.bundleURL.appendingPathComponent(state.diceImages[0]).path)
                Image(Bundle.module.bundleURL.appendingPathComponent(state.diceImages[1]).path)
                Image(Bundle.module.bundleURL.appendingPathComponent(state.diceImages[2]).path)
                Image(Bundle.module.bundleURL.appendingPathComponent(state.diceImages[3]).path)
                Image(Bundle.module.bundleURL.appendingPathComponent(state.diceImages[4]).path)
                Image(Bundle.module.bundleURL.appendingPathComponent(state.diceImages[5]).path)
            }
            Text("\(state.randomNumbers)")
            HStack() {
                Button("Roll") {
                    print("Rolling!")
                    state.randomNumbers.removeAll()
                    state.diceImages.removeAll()
                    for _ in 1...6 {
                        state.randomNumbers.append(Int.random(in: 1...6))
                    }
                    for n in 1...6 {
                        state.diceImages.append("Die\(state.randomNumbers[n-1]).svg")
                    }
                }
                Spacer()
            }
        }
    }
}
