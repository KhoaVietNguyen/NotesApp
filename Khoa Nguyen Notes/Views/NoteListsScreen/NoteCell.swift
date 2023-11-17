//
//  NoteCell.swift
//  Khoa Nguyen Notes
//
//  Created by Khoa Nguyen on 16/11/2023.
//

import SwiftUI

struct NoteCell: View {
    var noteData: NoteModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(noteData.note).font(.system(size: 18, weight: .medium))
            Spacer().frame(height: 5)
            Text(noteData.time).font(.system(size: 14, weight: .regular)).foregroundColor(.gray)
            Divider()
        }
        .font(.body)
        .listRowBackground(Color.clear)
    }
}

struct NameCell: View {
    var name: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            NavigationLink(destination: NoteListsView(nameUser: name, isShowAddBtn: false).navigationBarBackButtonHidden(true)) {
                Text(name)
            }
            Divider()
        }
        .font(.body)
        .listRowBackground(Color.clear)
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteCell(noteData: mockData[0])
    }
}
