//
//  ResultView.swift
//  QuizAppSwiftUI
//
//  Created by Meet Patel on 30/03/25.
//

import Foundation
import SwiftUI

struct ResultView: View {
    let score: Int
    let total: Int
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Quiz Completed!")
                .font(.largeTitle)
                .bold()

            Text("Score: \(score)/\(total)")
                .font(.title2)
                .padding(.bottom, 5)

            Text("Average = \(Double(score) / Double(total), specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.blue)

            Button("Back to Home") {
                dismiss()
            }
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
        }
        .padding()
    }
}
