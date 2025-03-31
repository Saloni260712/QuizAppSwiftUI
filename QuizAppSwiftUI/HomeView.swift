//
//  HomeView.swift
//  QuizAppSwiftUI
//
//  Created by Meet Patel on 30/03/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("My Quiz")
                    .font(.largeTitle)
                    .bold()

                NavigationLink(destination: QuestionBankView()) {
                    Text("+ Question Bank")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: QuizView()) {
                    Text("Start the Quiz")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
