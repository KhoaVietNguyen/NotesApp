//
//  FirebaseDatabaseUtils.swift
//  Khoa Nguyen Notes
//
//  Created by ALTEK on 16/11/2023.
//

import Foundation
import FirebaseDatabase
import SwiftUI

class FirebaseDatabaseUtils {
    @AppStorage("nameUser") var nameUser : String = ""
    private let ref = Database.database().reference()

    func insertData(_ data : Any?, completed : @escaping () -> Void?, failure : @escaping (_ error: Error?) -> Void?) {
        ref.child(nameUser).childByAutoId().setValue(data) { (error: Error?, databaseReference: DatabaseReference) in
            if (error == nil) {
                completed()
            } else {
                failure(error)
            }
        }
    }
    
    
    func readArrayData(key: String = "", completed : @escaping (_ data: DataSnapshot) -> Void?, failure : @escaping (_ error: Error?) -> Void?) {
        let child = nameUser.isEmpty ? key : nameUser
        ref.child(child).observe(.value) { data in
            completed(data)
        } withCancel: { error in
            failure(error)
        }
    }
    
    func readAllData(completed : @escaping (_ data: DataSnapshot) -> Void?, failure : @escaping (_ error: Error?) -> Void?) {
        ref.observe(.value) { data in
            completed(data)
        } withCancel: { error in
            failure(error)
        }
    }
    
    func deleteData(key: String = "", completed : @escaping () -> Void?, failure : @escaping (_ error: Error?) -> Void?) {
        let child = nameUser.isEmpty ? key : nameUser
        ref.child(child).removeValue { (error: Error?, databaseReference: DatabaseReference) in
            if (error == nil) {
                completed()
            } else {
                failure(error)
            }
        }
    }
}
