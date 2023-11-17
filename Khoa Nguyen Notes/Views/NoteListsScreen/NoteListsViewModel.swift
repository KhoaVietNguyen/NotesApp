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
    var allNoteList : [UserModel]  = [UserModel]()
    
    @Published
    var isLoading : Bool = false
    
    func getListNote(name : String = "") {
        self.isLoading = true
        self.noteList.removeAll()
        firebaseDatabaseUtils.readArrayData(key: name, completed: { dataSnapshot in
            self.isLoading = false
            if let snapshot = dataSnapshot.children.allObjects as? [DataSnapshot] {
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
    
    func getAllUserNote(name : String = "") {
        self.isLoading = true
        self.allNoteList.removeAll()
        firebaseDatabaseUtils.readAllData(completed: { dataSnapshot in
            self.isLoading = false
            if let snapshot = dataSnapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    
                    let name = snap.key
                    var noteList = [NoteModel]()
                    
                    if let snapshotChildren = snap.children.allObjects as? [DataSnapshot] {
                        for snapChil in snapshotChildren {
                            if let postDict = snapChil.value as? Dictionary<String, AnyObject>,
                               let note = postDict["note"] as? String,
                               let id =  UUID(uuidString: postDict["id"] as? String ?? ""){
                                noteList.append(NoteModel(id: id , note: note))
                            } else {
                                print("Failed to convert.")
                            }
                        }
                        noteList.reverse()
                    }
                    @AppStorage("nameUser") var nameUser : String = ""
                    let dataUser = UserModel(listNote: noteList, name: name)
                    
                    if name == nameUser {
                        self.allNoteList.insert(dataUser, at: 0)
                    } else {
                        self.allNoteList.append(dataUser)
                    }
                }
            }
        }) { error in
            self.isLoading = false
        }
    }
}
