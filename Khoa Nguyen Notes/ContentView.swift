//
//  ContentView.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                    Rectangle()
                        .fill(Gradient(colors: [.white, .orange]))
                        .ignoresSafeArea()
                VStack {
                    BackgroundApp()
                    InputNameView()
                    Spacer()
                }
                .navigationTitle(Text("Note App"))
                }
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
