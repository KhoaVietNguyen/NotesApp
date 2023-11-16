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
        VStack {
            TextField("", text: $name
                      ,prompt: Text("Enter your name")
                .foregroundColor(.gray))
            .foregroundColor(.black)
            Divider()
            Spacer().frame(height: 20)
            
            NavigationLink(destination: NoteListsView().navigationBarBackButtonHidden(true)) {
                Text("Confirm")
                .padding(.horizontal, 30.0)
                .padding(.vertical, 8)
                .background(Gradient(colors: [.red, .orange]))
                .foregroundStyle(.white)
                .cornerRadius(8)
            }
            
        }.padding(20)
        
    }
}

struct InputNameView_Previews: PreviewProvider {
    static var previews: some View {
        InputNameView()
    }
}
