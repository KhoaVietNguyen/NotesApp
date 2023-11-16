//
//  SwiftUIView.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import SwiftUI

struct NoteListsView: View {
    @StateObject
    var viewModel = NoteListsViewModel()
    @State var presentingModal = false
    @State var showMoreOption = false
    @State var showAllNote = false
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .fill(Gradient(colors: [.white, .orange]))
                        .ignoresSafeArea()
                    VStack {
                        Rectangle()
                            .frame(height: 0)
                            .background(LinearGradient(gradient: Gradient(colors: [.orange, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        ListNote
                    }
                    
                    VStack {
                        if self.showMoreOption {
                            Button(action: {
                                self.presentingModal = true
                            }, label: {
                                Image(systemName: "paperplane.fill")
                                    .font(.title.weight(.semibold))
                                    .padding(12)
                                    .background(Color.white)
                                    .foregroundColor(.orange)
                                    .clipShape(Circle())
                                
                            })
                            .padding(16)
                            .sheet(isPresented: $presentingModal) { AddNoteView(presentedAsModal: self.$presentingModal).presentationDetents([.height(250),.height(250)]) }
                            
                            Button(action: {
                                self.showMoreOption =  !self.showMoreOption
                                self.showAllNote = !self.showAllNote
                            }, label: {
                                Image(systemName: self.showAllNote ? "person.fill" : "person.2.fill")
                                    .font(.title.weight(.semibold))
                                    .padding(12)
                                    .background(Color.white)
                                    .foregroundColor(.orange)
                                    .clipShape(Circle())
                            })
                            .padding(.horizontal, 16)
                            .padding(.vertical, 0)
                        }
                        
                        Button(action: {
                            withAnimation {
                                self.showMoreOption =  !self.showMoreOption
                            }
                        }, label: {
                            Image(systemName: self.showMoreOption ? "arrow.down" : "plus")
                                .font(.title.weight(.semibold))
                                .padding(12)
                                .background(Color.white)
                                .foregroundColor(.orange)
                                .clipShape(Circle())
                            
                        })
                        .padding(16)
                       
                    }
                    
                    
                }.navigationBarTitle(Text("Notes list".uppercased()), displayMode: .inline)
            }
        }.onAppear{
            self.viewModel.getListNote()
        }
    }
    
    var ListNote: some View {
        return List {
            if self.showAllNote {
                Section(header: Text("Header")) {
                   ForEach(viewModel.noteList) { data in
                        NoteCell(noteData: data).listRowSeparator(.hidden).background(.clear)
                    }
                }
                .headerProminence(.increased)
            } else {
                ForEach(viewModel.noteList) { data in
                     NoteCell(noteData: data).listRowSeparator(.hidden).background(.clear)
                 }
            }

        }
        
        .listStyle(.plain)
        
        .refreshable {
            self.viewModel.getListNote()
        }
        .overlay {
            if viewModel.noteList.isEmpty {
                Text("Oops, looks like there's no data...").foregroundColor(.gray).padding()
            }
        }
        .onAppear {
            UIRefreshControl.appearance().tintColor = .orange
            UITableView.appearance().backgroundColor = UIColor.green
            UITableViewCell.appearance().backgroundColor = UIColor.green
        }.onTapGesture {
            self.showMoreOption = false
        }
    }
    
}

struct WrapperListView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .center) {
            content()
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}


struct NoteListsView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListsView()
    }
}
