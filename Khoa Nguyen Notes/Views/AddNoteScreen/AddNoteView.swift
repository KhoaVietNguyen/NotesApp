//
//  AddNoteView.swift
//  Khoa Nguyen Notes
//
//  Created by Khoa Nguyen on 16/11/2023.
//

import SwiftUI
import UIKit

struct AddNoteView: View {
    @Binding var presentedAsModal: Bool
    @FocusState private var keyboardFocused: Bool
    @StateObject var viewModel = AddNoteViewModel()
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Gradient(colors: [.white, .orange]))
                .ignoresSafeArea()
            if viewModel.text.isEmpty {
                VStack {
                    Text("Write something...")
                        .padding(.top, 24)
                        .padding(.leading, 24)
                        .foregroundColor(.black)
                        .opacity(0.6)
                    Spacer()
                }
            }
            VStack {
                TextEditor(text: $viewModel.text)
                    .padding()
                    .frame(minHeight: 100, maxHeight: 200)
                    .opacity(viewModel.text.isEmpty ? 0.85 : 1)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.black)
                    .focused($keyboardFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                keyboardFocused = true
                            }
                        }
                if !viewModel.text.isEmpty {
                    Button("Create") {
                        self.presentedAsModal = false
                        viewModel.addNote()
                    }
                    .padding(.horizontal, 30.0)
                    .padding(.vertical, 8)
                    .background(Gradient(colors: [.red, .orange]))
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                }
                Spacer()
            }
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(presentedAsModal: .constant(true))
    }
}
