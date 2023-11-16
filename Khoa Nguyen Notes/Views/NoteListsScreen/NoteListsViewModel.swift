//
//  NoteListsViewModel.swift
//  Khoa Nguyen Notes
//
//  Created by Khoa Nguyen on 16/11/2023.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseDatabase


class NoteListsViewModel : ObservableObject {
    private var firebaseDatabaseUtils = FirebaseDatabaseUtils()
    
    @Published
    var noteList : [NoteModel]  = [NoteModel]()
    
    @Published
    var isLoading : Bool = false
    
    func getListNote(name : String = "") {
        self.isLoading = true
        firebaseDatabaseUtils.readArrayData(key: name, completed: { dataSnapshot in
            self.isLoading = false
            if let snapshot = dataSnapshot.children.allObjects as? [DataSnapshot] {
                self.noteList.removeAll()
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject>,
                       let note = postDict["note"] as? String,
                       let id =  UUID(uuidString: postDict["id"] as? String ?? ""){
                        self.noteList.append(NoteModel(id: id , note: note))
                    } else {
                        print("Failed to convert.")
                    }
                }
                self.noteList.reverse()
            }
        }) { error in
            self.isLoading = false
        }
    }
    
    func getAllListNote(name : String = "") {
        self.isLoading = true
        firebaseDatabaseUtils.readAllData(completed: { dataSnapshot in
            self.isLoading = false
            if let snapshot = dataSnapshot.children.allObjects as? [DataSnapshot] {
                self.noteList.removeAll()
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, AnyObject>,
                       let note = postDict["note"] as? String,
                       let id =  UUID(uuidString: postDict["id"] as? String ?? ""){
                        self.noteList.append(NoteModel(id: id , note: note))
                    } else {
                        print("Failed to convert.")
                    }
                }
                self.noteList.reverse()
            }
        }) { error in
            self.isLoading = false
        }
    }
}
