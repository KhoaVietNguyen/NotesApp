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
            Text(noteData.note)
            Divider()
        }.font(.body)
            .listRowBackground(Color.clear)
    }
}

struct NoteCell_Previews: PreviewProvider {
    static var previews: some View {
        NoteCell(noteData: mockData[0])
    }
}
