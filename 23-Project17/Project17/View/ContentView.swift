//
//  ContentView.swift
//  Project17
//
//  Created by clarknt on 2020-01-01.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// Challenge 2
enum SheetType {
    case editCards, settings
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    @State private var cards = [Card]()
    @State private var timeRemaining = Self.initialTimerValue
    @State private var isActive = true
    // Challenge 2
    @State private var showingSheet = false

    // Challenge 1
    @State private var initialCardsCount = 0
    @State private var correctCards = 0
    @State private var incorrectCards = 0
    private var reviewedCards: Int {
        correctCards + incorrectCards
    }
    let haptics = Haptics()

    // Challenge 2
    @State private var retryIncorrectCards = false
    @State private var sheetType = SheetType.editCards

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    static let initialTimerValue = 100
    static let maxTimerDigits = String(Self.initialTimerValue).count

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
                TimerView(timeRemaining: timeRemaining, style: .variable)
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
                    ForEach(cards) { card in
                        // Challenge 1
                        CardView(card: card, retryIncorrectCards: self.retryIncorrectCards) { isCorrect in

                            // update stats
                            if isCorrect {
                                self.correctCards += 1
                            }
                            else {
                                self.incorrectCards += 1

                                // Challenge 2
                                if self.retryIncorrectCards {
                                    self.restackCard(at: self.index(for: card))
                                    return
                                }
                            }

                            // remove card
                            withAnimation {
                                self.removeCard(at: self.index(for: card))
                            }
                        }
                        .stacked(at: self.index(for: card), in: self.cards.count)
                        // allow dragging only the top card
                        .allowsHitTesting(self.index(for: card) == self.cards.count - 1)
                        // let voice over read only the top card
                        .accessibility(hidden: self.index(for: card) < self.cards.count - 1)
                    }
                    .allowsHitTesting(timeRemaining > 0)


                    // MARK: main UI/restart
                    // Challenge 1
                    if timeRemaining == 0 || !isActive {
                        RestartView(retryIncorrectCards: retryIncorrectCards,
                                    initialCardsCount: initialCardsCount,
                                    reviewedCards: reviewedCards,
                                    correctCards: correctCards,
                                    incorrectCards: incorrectCards,
                                    restartAction: resetCards)
                        // in comparison with the 450, 250 for each card
                        .frame(width: 300, height: 200)
                    }
                }
            }


            // MARK: settings button
            // Challenge 2
            VStack {
                HStack {
                    ActionButton(systemImage: "gear") {
                        self.showSheet(type: .settings)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()


            // MARK: edit mode button
            VStack {
                HStack {
                    Spacer()
                    ActionButton(systemImage: "plus.circle") {
                        self.showSheet(type: .editCards)
                    }
                }
                Spacer()
            }
            .padding()


            // MARK: accessibility
            if (differentiateWithoutColor || accessibilityEnabled) &&
                timeRemaining > 0 && isActive {
                VStack {
                    Spacer()

                    HStack {

                        // MARK: accessibility/incorrect buttom
                        ActionButton(systemImage: "xmark.circle") {
                            // Challenge 1
                            self.incorrectCards += 1

                            // Challenge 2
                            if self.retryIncorrectCards {
                                self.restackCard(at: self.cards.count - 1)
                                return
                            }

                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))

                        Spacer()


                        // MARK: accessibility/correct buttom
                        ActionButton(systemImage: "checkmark.circle") {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                                // Challenge 1
                                self.correctCards += 1
                            }
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            // Challenge 2
            if self.sheetType == .editCards {
                EditCards()
            }
            else if self.sheetType == .settings {
                SettingsView(retryIncorrectCards: self.$retryIncorrectCards)
            }
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

    // Challenge 2
    func restackCard(at index: Int) {
        guard index >= 0 else { return }

        let card = cards[index]
        cards.remove(at: index)
        cards.insert(card, at: 0)
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

    // Challenge 2
    func index(for card: Card) -> Int {
        return cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }

    // Challenge 2
    func showSheet(type: SheetType) {
        self.sheetType = type
        self.showingSheet = true
    }
}

struct TimerView: View {
    enum Style {
        case variable, fixed
    }

    let timeRemaining: Int
    let style: Style
    let displayLeadingZeros: Bool = true

    var body: some View {
        Group {
            if style == .variable {
                variableStyleTimer()
            }
            else {
                fixedStyleTimer()
            }
        }
    }

    private func variableStyleTimer() -> some View {
        VStack(alignment: .leading) {
            Text("Time: \(timeRemaining)")
            // avoid jitter
            Text("Time: \(String(repeating: "0", count: String(timeRemaining).count))")
                .hidden()
                .frame(height: 0)
        }
    }

    private func fixedStyleTimer() -> some View {
        HStack(spacing: 0) {
            Text("Time: ")
            ForEach(0..<ContentView.maxTimerDigits, id: \.self) { i in
                VStack(alignment: .center) {
                    self.timerDigitText(for: i)
                    // avoid jitter
                    Text("0").hidden().frame(height: 0)
                }
            }
        }
    }

    private func timerDigitText(for position: Int) -> Text {
        let stringTimeRemaining = Array(String(timeRemaining))

        let index = position - (ContentView.maxTimerDigits - stringTimeRemaining.count)

        if index >= 0 {
            return Text(String(stringTimeRemaining[index]))
        }

        if displayLeadingZeros {
            return Text("0").foregroundColor(Color.white.opacity(0.2))
        }

        return Text("")
    }
}

// Challenge 1
struct RestartView: View {
    let retryIncorrectCards: Bool
    let initialCardsCount: Int
    let reviewedCards: Int
    let correctCards: Int
    let incorrectCards: Int
    let restartAction: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.black)

            VStack(alignment: .center) {
                Text("Statistics")
                    .font(.headline)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Cards" + (retryIncorrectCards ? " (unique)" : ""))
                        Text("Reviewed")
                        Text("Correct")
                        Text("Incorrect")
                    }
                    VStack(alignment: .trailing) {
                        Text("\(initialCardsCount)")
                        Text("\(reviewedCards)")
                        Text("\(correctCards)")
                        Text("\(incorrectCards)")
                    }
                }
                .font(.subheadline)
                .padding(.bottom)

                Button("Start Again", action: restartAction)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            .foregroundColor(.white)
        }
    }
}


// Challenge 2
struct ActionButton: View {
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .padding()
                .background(Color.black.opacity(0.7))
                .clipShape(Circle())
        }
        .foregroundColor(.white)
        .font(.largeTitle)
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
