//
//  OtherUserListView.swift
//  Khoa Nguyen Notes
//
//  Created by Khoa Nguyen on 17/11/2023.
//

import SwiftUI

struct OtherUserListView: View {
    @StateObject var viewModel = NoteListsViewModel()
    @State var presentingModal = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .fill(Gradient(colors: [.white, .orange]))
                        .ignoresSafeArea()
                    VStack {
                        BackgroundApp()
                        
                        List {
                            ForEach(viewModel.allNoteList) { data in
                                NameCell(name: data.name).listRowSeparator(.hidden).background(.clear)
                            }
                        }
                        .listStyle(.plain)
                        .refreshable {
                            self.viewModel.getAllUserNote()
                        }
                        .overlay {
                            if viewModel.allNoteList.isEmpty {
                                Text("Oops, looks like there's no data...").foregroundColor(.black).padding()
                            }
                        }
                        .onAppear {
                            UIRefreshControl.appearance().tintColor = .orange
                            UITableView.appearance().backgroundColor = UIColor.green
                            UITableViewCell.appearance().backgroundColor = UIColor.green
                        }.navigationTitle(Text("Another Users"))
                            .navigationBarItems(leading: Button(action: {
                                withAnimation {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }, label: {
                                Image(systemName: "arrow.backward.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.title.weight(.regular))
                                    .frame(width: 20, height: 20)
                        }))
                    }
                }
            }
        }
        .onAppear{
            self.viewModel.getAllUserNote()
        }
    }
}

struct OtherUserListView_Previews: PreviewProvider {
    static var previews: some View {
        OtherUserListView()
    }
}
