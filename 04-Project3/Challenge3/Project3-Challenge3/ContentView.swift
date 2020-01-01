//
//  ContentView.swift
//  Project3-Challenge3
//
//  Created by clarknt on 2019-10-12.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

// project 3 - challenge 3
struct FlagImage: View {
    var name: String

    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    //challenge 1
    @State private var score = 0

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Find the flag of")
                        .foregroundColor(.white)

                    // additional HStack with Spacers forces
                    // VStack to take full width, avoiding
                    // truncating country text
                    HStack {
                        Spacer()

                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)

                        Spacer()
                    }
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {

                        // project 3 - challenge 3
                        FlagImage(name: self.countries[number])
                    }
                }

                // challenge 2
                Text("Score: \(score)")
                    .foregroundColor(.white)

                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(self.score)") /* challenge 1 */, dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1 // challenge 1
        }
        else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])" // challenge 3
            score -= 1 // challenge 1
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
