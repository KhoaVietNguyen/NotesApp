//
//  NoteModel.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import Foundation

struct NoteModel : Codable, Identifiable {
    var id = UUID()
    var note : String!
    var time : String!
}

struct UserModel : Codable, Identifiable {
    var id = UUID()
    var name : String!
}

let mockData = [
    NoteModel(note: "Hôm nay buồn"),
    NoteModel(note: "Hôm nay buồn"),
    NoteModel(note: "Hôm nay buồn"),
    NoteModel(note: "Hôm nay buồn"),
    NoteModel(note: "Hôm nay buồn"),
]
