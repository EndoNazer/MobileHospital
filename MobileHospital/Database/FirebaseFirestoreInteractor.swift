//
//  FirebaseFirestoreInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 10.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation
import Firebase

class FirebaseFirestoreInterctor {
    
    static let db = Firestore.firestore()
    
    static func addNewDocument(collection: String, data: [String: Any]) {
        var ref: DocumentReference? = nil
        ref = db.collection(collection).addDocument(data: data) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    static func readAllDocuments(collection: String) -> [String: Any] {
        var documents: [String: Any] = [:]
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let singleDocument: [String: Any] = [document.documentID: document.data()]
                    documents[document.documentID] = singleDocument
                }
            }
        }
        return documents
    }
    
    static func readSingleDocument(collection: String, id: String) -> [String: Any] {
        var singleDocument: [String: Any] = [:]
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if document.data()["id"] as? String == id {
                        singleDocument = document.data()
                    }
                }
            }
        }
        return singleDocument
    }
    
}
