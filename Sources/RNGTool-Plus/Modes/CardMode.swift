/*  RNGTool Plus "CardMode.swift"
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

class CardModeState: Observable {
    @Observed var numOfCards: Int? = 1
    @Observed var randomNumbers: [Int] = []
    @Observed var randomNumberStr: String = "Click Draw to begin"
    @Observed var cardPoints: [Int] = []
    @Observed var cardImages: [String] = ["CardAce.svg", "CardAce.svg", "CardAce.svg", "CardAce.svg", "CardAce.svg", "CardAce.svg", "CardAce.svg"]
    @Observed var showPointValues: Bool = false
}

struct CardMode: View {

    var state = CardModeState()

    let cardList: [String] = ["CardAce.svg", "Card2.svg", "Card3.svg", "Card4.svg", "Card5.svg", "Card6.svg", "Card7.svg", "Card8.svg", "Card9.svg", "Card10.svg", "CardJack.svg", "CardQueen.svg", "CardKing.svg"]

    var body: some View {
        VStack() {
            HStack() {
                ForEach(0..<state.numOfCards!) { index in
                    Image(Bundle.module.bundleURL.appendingPathComponent(state.cardImages[index]).path)
                        .frame(minWidth: 65)
                }
            }
            if (state.showPointValues) {
                Text(state.randomNumberStr)
            }
            HStack() {
                Text("Number of cards:")
                Picker(of: [1,2,3,4,5,6,7], selection: state.$numOfCards)
                Spacer()
            }
            Toggle("Show point values", active: state.$showPointValues)
                .toggleStyle(.switch)
            HStack() {
                Button("Draw") {
                    state.randomNumbers.removeAll()
                    state.cardPoints.removeAll()
                    for _ in 1...state.numOfCards! {
                        state.randomNumbers.append(Int.random(in: 1...13))
                    }
                    for n in 0..<state.numOfCards! {
                        state.cardImages[n] = cardList[state.randomNumbers[n]-1]
                    }
                    for n in 0..<state.numOfCards! {
                        if state.randomNumbers[n] > 10 {
                            state.cardPoints.append(10)
                        }
                        else {
                            state.cardPoints.append(state.randomNumbers[n])
                        }
                    }
                    state.randomNumberStr = "Point value(s): \(state.cardPoints)"
                    state.randomNumberStr = state.randomNumberStr.replacingOccurrences(of: "[", with: "")
                    state.randomNumberStr = state.randomNumberStr.replacingOccurrences(of: "]", with: "")
                }
                Button("Reset") {
                    state.numOfCards = 1
                    state.randomNumbers.removeAll()
                    for n in 0..<7 {
                        state.cardImages[n] = cardList[0]
                    }
                    state.randomNumberStr = "Click Roll to begin"
                }
                Spacer()
            }
        }
    }
}