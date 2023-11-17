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
    @State var isAddSuccess = false
    @State var nameUser : String = ""
    @State var isShowAddBtn = true
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
                        withAnimation{
                            List {
                                ForEach(viewModel.noteList) { data in
                                    NoteCell(noteData: data).listRowSeparator(.hidden).background(.clear)
                                }
                            }
                            .listStyle(.plain)
                            .refreshable {
                                self.viewModel.getListNote(name: self.nameUser)
                            }
                            .overlay {
                                
                                if viewModel.noteList.isEmpty {
                                    Text("Oops, looks like there's no data...").foregroundColor(.black).padding()
                                }
                                
                            }
                            .onAppear {
                                UIRefreshControl.appearance().tintColor = .orange
                                UITableView.appearance().backgroundColor = UIColor.green
                                UITableViewCell.appearance().backgroundColor = UIColor.green
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("\(nameUser)'s Note".capitalized), displayMode: .automatic)
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
                .toolbar {
                    if isShowAddBtn {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: OtherUserListView().navigationBarBackButtonHidden(true)) {
                                Image(systemName: "person.2.circle.fill")
                                    .font(.title.weight(.medium))
                                    .foregroundColor(.orange)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 20)
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                self.presentingModal = true
                            }, label: {
                                Image(systemName: "square.and.pencil.circle.fill")
                                    .font(.title.weight(.medium))
                                    .foregroundColor(.orange)
                                    .background(Color.white)
                                    .clipShape(Circle())
                            })
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 8)
                            .sheet(isPresented: $presentingModal) {
                                AddNoteView(presentedAsModal: $presentingModal, isAddSuccess: $isAddSuccess)
                                    .presentationDetents([.height(200),.height(200)]).onDisappear() {
                                        if(self.isAddSuccess){
                                            self.viewModel.getListNote(name: self.nameUser)
                                            self.isAddSuccess = false
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }.onAppear{
            self.viewModel.getListNote(name: self.nameUser)
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
        NoteListsView(nameUser: "khoa")
    }
}
