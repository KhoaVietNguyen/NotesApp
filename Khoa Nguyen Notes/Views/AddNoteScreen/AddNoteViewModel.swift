//
//  AddNoteViewModel.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import Foundation
import UIKit
import SwiftUI


class AddNoteViewModel : ObservableObject {
    private var firebaseDatabaseUtils = FirebaseDatabaseUtils()
    
    @Published
    var isSuccess : Bool!
    
    @Published
    var isLoading : Bool!
    
    @Published
    var text : String = ""
    
    func addNote() {
        self.isLoading = true
        let data = NoteModel(note : text.trimmingCharacters(in: .whitespacesAndNewlines))

        firebaseDatabaseUtils.insertData(data.toDictionary) {
            self.isLoading = false
            self.isSuccess = true
        } failure: { error in
            self.isLoading = false
            self.isSuccess = false
        }

    }
}
