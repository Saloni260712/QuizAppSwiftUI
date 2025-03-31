//
//  AddQuestionView.swift
//  QuizAppSwiftUI
//
//  Created by Meet Patel on 30/03/25.
//

import Foundation
import SwiftUI

struct AddQuestionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var questionText = ""
    @State private var options = ["", "", "", ""]
    @State private var correctIndex = 0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Enter the Question")) {
                TextField("Question", text: $questionText)
            }
            Section(header: Text("Enter the Correct Answer")) {
                TextField("Correct Answer", text: $options[0])
            }
            Section(header: Text("Enter the First Incorrect Answer")) {
                TextField("Incorrect Answer 1", text: $options[1])
            }
            Section(header: Text("Enter the Second Incorrect Answer")) {
                TextField("Incorrect Answer 2", text: $options[2])
            }
            Section(header: Text("Enter the Third Incorrect Answer")) {
                TextField("Incorrect Answer 3", text: $options[3])
            }

            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(10)
                }

                Button(action: {
                    let newQuestion = QuestionEntity(context: viewContext)
                    newQuestion.questionText = questionText
                    newQuestion.option1 = options[0]
                    newQuestion.option2 = options[1]
                    newQuestion.option3 = options[2]
                    newQuestion.option4 = options[3]
                    newQuestion.correctAnswerIndex = Int16(correctIndex)

                    do {
                        try viewContext.save()
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Failed to save question: \(error.localizedDescription)")
                    }
                }) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(10)
                }
            }
        }
        .navigationTitle("Add Question")
    }
}
