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
                VStack {
                    HStack {
                        Button(action: {
                            self.presentedAsModal = false
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title.weight(.medium))
                                .foregroundColor(.orange)
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .frame(width: 20, height: 20)
                        .padding(.horizontal, 20)
                        
                        Text("Write Note")
                            .foregroundColor(.black)
                            .opacity(0.8)
                            .font(.system(size: 20, weight: .semibold))
                        Spacer()
                        
                        if !viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Button(action: {
                                viewModel.addNote()
                            }, label: {
                                Image(systemName: "square.and.arrow.up.circle.fill")
                                    .font(.title.weight(.medium))
                                    .foregroundColor(.orange)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            })
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 20)
                        }
                    }.padding(.top, 24)
                    
                    TextEditor(text: $viewModel.text)
                        .font(.system(size: 24))
                        .frame(minHeight: 100, maxHeight: 200)
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.black)
                        .focused($keyboardFocused, equals: .field)
                        .task {
                            self.keyboardFocused = .field
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    
                    .onAppear {
                        self.bindViewModel()
                    }
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
