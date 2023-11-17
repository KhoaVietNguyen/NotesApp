//
//  AddNoteView.swift
//  Khoa Nguyen Notes
//
//  Created by Khoa Nguyen on 16/11/2023.
//

import SwiftUI
import UIKit

struct AddNoteView: View {
    enum FocusField: Hashable {
        case field
      }
    
    @Binding var presentedAsModal: Bool
    @FocusState private var keyboardFocused: FocusField?
    @StateObject var viewModel = AddNoteViewModel()
    @Binding var isAddSuccess: Bool
    
    var body: some View {
        return LoadingView(isShowing: $viewModel.isLoading) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Gradient(colors: [.white, .orange]))
                    .ignoresSafeArea()
                if viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
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
                        .focused($keyboardFocused, equals: .field)
                        .task {
                            self.keyboardFocused = .field
                        }
                    
                    if !viewModel.text.isEmpty {
                        Button("Create") {
                            viewModel.addNote()
                        }
                        .padding(.horizontal, 30.0)
                        .padding(.vertical, 8)
                        .background(LinearGradient(gradient: Gradient(colors: [.orange, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                    }
                    Spacer()
                }
                .onAppear {
                    self.bindViewModel()
                }
                
            }
        }
    }
    
    func bindViewModel() {
        self.viewModel.onState = { state in
            switch (state) {
            case .success:
                self.presentedAsModal = false
                self.isAddSuccess = true
                break
            case .failed(let errorMessage):
                //handle error
                break
            default: break
            }
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(presentedAsModal: .constant(true), isAddSuccess: .constant(true))
    }
}
