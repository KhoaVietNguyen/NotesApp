//
//  InputNameView.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import SwiftUI

struct InputNameView: View {
    @AppStorage("nameUser") var name : String = "" {
        didSet {
            UserDefaults.standard.set(name, forKey: "nameUser")
        }
    }
    var body: some View {
        VStack(alignment: .center, spacing: 8,  content: {
            Spacer().frame(height: 16)
            HStack{
                TextField("", text: $name ,prompt: Text("Enter your name").foregroundColor(.gray).font(.system(size: 20, weight: .regular)))
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                if !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    withAnimation {
                        NavigationLink(destination: NoteListsView(nameUser: name).navigationBarBackButtonHidden(true)) {
                            Image(systemName: "arrow.forward.circle.fill")
                                .foregroundColor(.orange)
                                .font(.title.weight(.semibold))
                                .frame(width: 23, height: 23)
                        }
                    }
                }
            }
            Divider()
        }).padding(20)
        
    }
}

struct InputNameView_Previews: PreviewProvider {
    static var previews: some View {
        InputNameView()
    }
}
