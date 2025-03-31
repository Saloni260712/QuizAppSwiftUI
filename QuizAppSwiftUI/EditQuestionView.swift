//
//  EditQuestionView.swift
//  QuizAppSwiftUI
//
//  Created by Meet Patel on 30/03/25.
//

import Foundation
import SwiftUI

struct EditQuestionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @ObservedObject var question: QuestionEntity
    @State private var questionText: String = ""
    @State private var answers: [String] = ["", "", "", ""]
    @State private var correctIndex: Int = 0

    var body: some View {
        Form {
            Section(header: Text("UPDATE THE QUESTION")) {
                TextField("Question", text: $questionText)
            }
            Section(header: Text("UPDATE THE ANSWERS")) {
                ForEach(0..<4, id: \..self) { index in
                    TextField("Answer \(index + 1)", text: $answers[index])
                }
                Picker("Correct Option", selection: $correctIndex) {
                    ForEach(0..<4, id: \..self) {
                        Text("Option \($0 + 1)").tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
            }

            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red.opacity(0.2))
                .cornerRadius(12)

                Button("Save") {
                    updateQuestion()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.3))
                .cornerRadius(12)
            }
        }
        .onAppear(perform: populateData)
        .navigationTitle("Edit Question")
    }

    private func populateData() {
        questionText = question.questionText ?? ""
        answers = [question.option1 ?? "", question.option2 ?? "", question.option3 ?? "", question.option4 ?? ""]
        correctIndex = Int(question.correctAnswerIndex)
    }

    private func updateQuestion() {
        question.questionText = questionText
        question.option1 = answers[0]
        question.option2 = answers[1]
        question.option3 = answers[2]
        question.option4 = answers[3]
        question.correctAnswerIndex = Int16(correctIndex)

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Failed to update question: \(error.localizedDescription)")
        }
    }
}
