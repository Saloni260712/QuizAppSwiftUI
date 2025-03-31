//
//  QuestionBankView.swift
//  QuizAppSwiftUI
//
//  Created by Meet Patel on 30/03/25.
//

import Foundation
import SwiftUI
import CoreData

struct QuestionBankView: View {
    @FetchRequest(
        entity: QuestionEntity.entity(),
        sortDescriptors: []
    ) var questions: FetchedResults<QuestionEntity>

    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedQuestion: QuestionEntity?
    @State private var showEditView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(questions) { question in
                    Button(action: {
                        selectedQuestion = question
                        showEditView = true
                    }) {
                        VStack(alignment: .leading) {
                            Text(question.questionText ?? "")
                                .font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteQuestions)
            }
            .navigationTitle("Question Bank")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddQuestionView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $selectedQuestion) { question in
                EditQuestionView(question: question)
            }
        }
    }

    private func deleteQuestions(at offsets: IndexSet) {
        for index in offsets {
            viewContext.delete(questions[index])
        }
        do {
            try viewContext.save()
        } catch {
            print("Error deleting question: \(error)")
        }
    }
}
