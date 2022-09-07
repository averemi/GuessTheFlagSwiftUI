//
//  ContentView.swift
//  GuessTheFlagSwiftUI
//
//  Created by Anastasiia Veremiichyk on 03/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAnswer = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    
    @State private var countries = ["Ukraine", "Estonia", "France", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var chosenAnswer = ""
    
    @State private var questionCount = 0
    
    @ViewBuilder var gradientView: some View {
        RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
        ], center: .top, startRadius: 200, endRadius: 700)
    }
    
    @ViewBuilder var flagsView: some View {
        VStack(spacing: 15) {
            VStack {
                Text("Tap the flag of")
                    .foregroundStyle(.secondary)
                    .font(.subheadline.weight(.heavy))
                Text(countries[correctAnswer])
                    .font(.largeTitle.weight(.semibold))
            }

            ForEach(0..<3) { number in
                Button {
                    flagTapped(number)
                } label: {
                    Image(countries[number])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                }
            }
        }
    }

    var body: some View {
        ZStack {
            gradientView
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                flagsView
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(totalScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingAnswer) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("This is the flag of \(chosenAnswer)")
        }
        .alert(scoreTitle, isPresented: $showingFinalScore) {
            Button("Restart", action: restart)
            Button("Dismiss") {}
        } message: {
            Text("Your final score is \(totalScore)" + "\n" + "Would you like to restart?")
        }
    }
    
    func flagTapped(_ number: Int) {
        chosenAnswer = countries[number]
        totalScore = number == correctAnswer ? totalScore + 1 : totalScore
        scoreTitle = number == correctAnswer ? "Corect" : "Wrong"
        questionCount += 1
        guard questionCount <= 7 else {
            showingFinalScore = true
            return
        }
    
        if number == correctAnswer {
            askQuestion()
        } else {
            showingAnswer = true
        }
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart() {
        askQuestion()
        questionCount = 0
        totalScore = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
