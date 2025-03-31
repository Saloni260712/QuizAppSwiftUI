//
//  QuizView.swift
//  QuizAppSwiftUI
//
//  Created by Meet Patel on 30/03/25.
//

import Foundation
import SwiftUI
import CoreData

struct QuizView: View {
    @FetchRequest(
        entity: QuestionEntity.entity(),
        sortDescriptors: []
    ) var questions: FetchedResults<QuestionEntity>

    @State private var currentIndex = 0
    @State private var selectedOption: Int? = nil
    @State private var score = 0
    @State private var showResult = false

    var body: some View {
        VStack(spacing: 20) {
            if currentIndex < questions.count {
                let question = questions[currentIndex]

                Text("Question \(currentIndex + 1) of \(questions.count)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text(question.questionText ?? "")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()

                ForEach(0..<4, id: \..self) { index in
                    Button(action: {
                        selectedOption = index
                        if index == question.correctAnswerIndex {
                            score += 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            currentIndex += 1
                            selectedOption = nil
                            if currentIndex == questions.count {
                                showResult = true
                            }
                        }
                    }) {
                        Text(optionText(for: question, index: index))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(backgroundColor(for: index, correct: question.correctAnswerIndex))


                            .cornerRadius(10)
                    }
                }

                ProgressView(value: Double(currentIndex + 1), total: Double(questions.count))
                    .padding()
            } else {
                Text("No Questions Available")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .navigationTitle("Quiz")
        .sheet(isPresented: $showResult) {
            ResultView(score: score, total: questions.count)
        }
    }
    
    func backgroundColor(for index: Int, correct: Int16) -> Color {
        if let selected = selectedOption {
            if index == selected && index == correct {
                return Color.green.opacity(0.4)
            } else if index == selected && index != correct {
                return Color.red.opacity(0.4)
            } else if index == correct {
                return Color.green.opacity(0.2) 
            }
        }
        return Color.blue.opacity(0.2) // Default
    }

    func optionText(for question: QuestionEntity, index: Int) -> String {
        switch index {
        case 0: return question.option1 ?? ""
        case 1: return question.option2 ?? ""
        case 2: return question.option3 ?? ""
        case 3: return question.option4 ?? ""
        default: return ""
        }
    }
}
