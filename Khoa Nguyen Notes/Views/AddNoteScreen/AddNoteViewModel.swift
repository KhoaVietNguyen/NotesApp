//
//  AddNoteViewModel.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import Foundation
import UIKit
import SwiftUI

enum AddNoteState {
    case `none`, success, failed(Error)
}

class AddNoteViewModel : ObservableObject {
    private var firebaseDatabaseUtils = FirebaseDatabaseUtils()
    
    @Published
    var isSuccess : Bool!
    
    @Published
    var isLoading : Bool = false
    
    @Published
    var text : String = ""
    
    var onState: ((AddNoteState) -> Void)?
    private var viewModelAddNote: AddNoteState = .none {
        didSet { onState?(viewModelAddNote) }
    }
    
    func addNote() {
        self.isLoading = true
        let data = NoteModel(note : text.trimmingCharacters(in: .whitespacesAndNewlines), time: Date().dateAndTimetoString())

        firebaseDatabaseUtils.insertData(data.toDictionary) {
            self.viewModelAddNote = .success
            self.isSuccess = true
        } failure: { error in
            self.isLoading = false
            self.isSuccess = false
            self.viewModelAddNote = .failed(error!)
        }

    }
}
