//
//  SwiftUIView.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import SwiftUI

struct NoteListsView: View {
    @StateObject var viewModel = NoteListsViewModel()
    @State var presentingModal = false
    @State var showMoreOption = false
    @State var showAllNote = false
    @State var isAddSuccess = false
    
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
                        ScrollViewReader { proxy in
                            List {
                                if self.showAllNote {
                                    ForEach(viewModel.allNoteList) { data in
                                        Section(header: HStack {
                                            Text(data.name).padding()
                                                .font(.system(size: 18, weight: .bold))
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                
                                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        .background(LinearGradient(gradient: Gradient(colors: [.orange, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))) {
                                            ForEach(data.listNote) { data in
                                                NoteCell(noteData: data).listRowSeparator(.hidden).background(.clear)
                                            }
                                        }
                                    }
                                } else {
                                    ForEach(viewModel.noteList) { data in
                                        NoteCell(noteData: data).listRowSeparator(.hidden).background(.clear)
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .refreshable {
                                if self.showAllNote {
                                    self.viewModel.getAllUserNote()
                                } else {
                                    self.viewModel.getListNote()
                                }
                            }
                            .overlay {
                                if showAllNote {
                                    if viewModel.allNoteList.isEmpty {
                                        Text("Oops, looks like there's no data...").foregroundColor(.black).padding()
                                    }
                                } else {
                                    if viewModel.noteList.isEmpty {
                                        Text("Oops, looks like there's no data...").foregroundColor(.black).padding()
                                    }
                                }
                            }
                            .onAppear {
                                UIRefreshControl.appearance().tintColor = .orange
                                UITableView.appearance().backgroundColor = UIColor.green
                                UITableViewCell.appearance().backgroundColor = UIColor.green
                            }
                            .onTapGesture {
                                self.showMoreOption = false
                            }
                            .padding(8)
                            .onChange(of: true) { newValue in
                                proxy.scrollTo(0)
                            }
                        }
                    }
                    
                    VStack {
                        if self.showMoreOption {
                            Button(action: {
                                withAnimation {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }, label: {
                                Image(systemName: "chevron.backward")
                                    .font(.title.weight(.semibold))
                                    .padding(12)
                                    .background(Color.white)
                                    .foregroundColor(.orange)
                                    .clipShape(Circle())
                                
                            })
                            .padding(16)
                            
                            
                            Button(action: {
                                self.showMoreOption.toggle()
                                self.showAllNote.toggle()
                                self.viewModel.getAllUserNote()
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
                                self.showMoreOption.toggle()
                            }
                        }, label: {
                            Image(systemName: self.showMoreOption ? "square.3.layers.3d.down.forward" : "square.stack.3d.down.forward.fill")
                                .font(.title.weight(.semibold))
                                .padding(12)
                                .background(Color.white)
                                .foregroundColor(.orange)
                                .clipShape(Circle())
                        })
                        .padding(16)
                        
                    }
                    
                    
                }
                .navigationBarTitle(Text( self.showAllNote ? "All Notes".uppercased() : "Note".uppercased()), displayMode: .automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.presentingModal = true
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title.weight(.semibold))
                                .padding(6)
                                .background(Color.white)
                                .foregroundColor(.orange)
                                .clipShape(Circle())
                        })
                        .padding(.top, 24)
                        .sheet(isPresented: $presentingModal) {
                            AddNoteView(presentedAsModal: $presentingModal, isAddSuccess: $isAddSuccess)
                                .presentationDetents([.height(250),.height(250)]).onDisappear() {
                                    if(self.isAddSuccess){
                                        if self.showAllNote {
                                            self.viewModel.getAllUserNote()
                                        } else {
                                            self.viewModel.getListNote()
                                        }
                                        self.isAddSuccess = false
                                    }
                                }
                        }
                        
                    }
                }
            }
        }.onAppear{
            self.viewModel.getListNote()
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
