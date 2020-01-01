//
//  ContentView.swift
//  Project5
//
//  Created by clarknt on 2019-10-22.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    // challenge 1
    private let minWordLength = 3

    // challenge 3
    private var score: Int {
        var count = 0
        for word in usedWords {
            count += word.count
        }
        return count
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)

                List(usedWords, id: \.self) {
                    // HStack is added automatically if there are several elements on the same row

                    // add number of letters
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }

                // challenge 3
                Text("Score: \(score)")
            }
            .navigationBarTitle(rootWord)
            // challenge 2
            .navigationBarItems(leading: Button("New Game") { self.startGame() })
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func startGame() {
        // challenge 2
        usedWords.removeAll()

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")

                rootWord = allWords.randomElement() ?? "silkworm"

                return
            }
        }

        fatalError("Could not load start.txt from bundle.")
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard answer.count > 0 else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }

        // challenge 1
        guard isLongEnough(word: answer) else {
            wordError(title: "Word too short", message: "Words must be \(minWordLength) letters at least")
            return
        }

        // challenge 1
        guard isNotWordToGuess(word: answer) else {
            wordError(title: "Incorrect word", message: "Word must be different than word to guess")
            return
        }

        // insert on top of the list
        usedWords.insert(answer, at: 0)
        newWord = ""
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }
            else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    // challenge 1
    func isLongEnough(word: String) -> Bool {
        return word.count >= minWordLength
    }

    // challenge 1
    func isNotWordToGuess(word: String) -> Bool {
        return word != rootWord
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
