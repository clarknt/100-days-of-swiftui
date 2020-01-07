//
//  ContentView.swift
//  Project17
//
//  Created by clarknt on 2020-01-01.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    @State private var cards = [Card]()
    @State private var timeRemaining = Self.initialTimerValue
    @State private var isActive = true
    @State private var showingEditScreen = false

    // Challenge 1
    @State private var initialCardsCount = 0
    @State private var correctCards = 0
    @State private var incorrectCards = 0
    private var reviewedCards: Int {
        correctCards + incorrectCards
    }
    let haptics = Haptics()

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private static let initialTimerValue = 100

    var body: some View {
        ZStack {
            // MARK: background
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            // MARK: main UI
            VStack {
                // MARK: main UI/time
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )

                ZStack {
                    // MARK: main UI/cards
                    ForEach(0..<cards.count, id: \.self) { index in
                        // Challenge 1
                        CardView(card: self.cards[index]) { isCorrect in
                            withAnimation {
                                self.removeCard(at: index)
                            }
                            if isCorrect {
                                self.correctCards += 1
                            }
                            else {
                                self.incorrectCards += 1
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                        // allow dragging only the top card
                        .allowsHitTesting(index == self.cards.count - 1)
                        // let voice over read only the top card
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                    .allowsHitTesting(timeRemaining > 0)

                    // MARK: main UI/restart
                    // Challenge 1
                    if cards.isEmpty || timeRemaining == 0 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.black)

                            VStack(alignment: .center) {
                                Text("Statistics")
                                    .font(.headline)

                                VStack {
                                    Text("Cards reviewed: \(reviewedCards) / \(initialCardsCount)")
                                    Text("Correct answers: \(correctCards) / \(reviewedCards)")
                                    Text("Incorrect answers: \(incorrectCards) / \(reviewedCards)")
                                }
                                .font(.subheadline)
                                .padding(.bottom)

                                Button("Start Again", action: resetCards)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                            }
                            .foregroundColor(.white)
                        }
                        // in comparison with the 450, 250 for each card
                        .frame(width: 300, height: 200)
                    }
                }
            }

            // MARK: edit mode button
            VStack {
                HStack {
                    Spacer()

                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            // MARK: accessibility
            if (differentiateWithoutColor || accessibilityEnabled) && timeRemaining > 0 {
                VStack {
                    Spacer()

                    HStack {
                        Button(
                            action: {
                                withAnimation {
                                    self.removeCard(at: self.cards.count - 1)
                                    // Challenge 1
                                    self.incorrectCards += 1
                                }
                            },
                            label: {
                                Image(systemName: "xmark.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                        )
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))

                        Spacer()

                        Button(
                            action: {
                                withAnimation {
                                    self.removeCard(at: self.cards.count - 1)
                                    // Challenge 1
                                    self.correctCards += 1
                                }
                            },
                            label: {
                                Image(systemName: "checkmark.circle")
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                            }
                        )
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard self.isActive else { return }

            if self.timeRemaining > 0 {
                self.timeRemaining -= 1

                // Challenge 1
                if self.timeRemaining == 2 {
                    self.haptics.prepare()
                }
                else if self.timeRemaining == 0 {
                    self.haptics.playEnding()
                }
            }
        }
        // app will go to background
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        // app is back to foreground
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
    }

    func removeCard(at index: Int) {
        guard index >= 0 else { return }

        cards.remove(at: index)

        // Challenge 1
        if cards.count == 1 {
            haptics.prepare()
        }

        if cards.isEmpty {
            isActive = false
            // Challenge 1
            haptics.playEnding()
        }
    }

    func resetCards() {
        timeRemaining = Self.initialTimerValue
        isActive = true
        loadData()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded

                // Challenge 1
                self.initialCardsCount = cards.count
                self.correctCards = 0
                self.incorrectCards = 0
                if cards.count == 1 {
                    self.haptics.prepare()
                }
            }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
