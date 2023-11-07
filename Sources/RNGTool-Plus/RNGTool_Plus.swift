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

enum SelectedMode {
    case numbers
    case dice
    case cards
    case marbles
}

class RNGToolState: Observable {
    @Observed var selectedMode: SelectedMode?
}

@main
struct RNGTool_Plus_App: App {
    typealias Backend = GtkBackend

    let identifier = "com.NCX-Programming.RNGTool-Plus"

    var state = RNGToolState()

    let windowProperties = WindowProperties(
        title: "RNGTool Plus",
        defaultSize: .init(640, 370)
    )

    var body: some View {
        NavigationSplitView {
            VStack {
                Button("Numbers") { state.selectedMode = .numbers }
                Button("Dice") { state.selectedMode = .dice }
                Button("Cards") { state.selectedMode = .cards }
                Button("Marbles") { state.selectedMode = .marbles }
                Spacer()
                Text("v1.0.0")
            }.padding(10)
        } detail: {
            VStack {
                switch state.selectedMode {
                    case .numbers:
                        NumberMode()
                            .padding(.bottom, 10)
                    case .dice:
                        DiceMode()
                            .padding(.bottom, 10)
                    case .cards:
                        CardMode()
                            .padding(.bottom, 10)
                    case .marbles:
                        MarbleMode()
                            .padding(.bottom, 10)
                    case nil:
                        Text("Select a mode to start generating")
                            .padding(.bottom, 10)
                }
            }.padding(10)
        }
    }
}
