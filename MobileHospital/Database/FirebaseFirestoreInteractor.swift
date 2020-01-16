//
//  FirebaseFirestoreInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 10.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation
import Firebase

class FirebaseFirestoreInteractor {
    
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
    
    static func readAllDocuments(collection: String, completion: @escaping (([String: Any]) -> Void)) {
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var documents: [String: Any] = [:]
                for document in querySnapshot!.documents {
                    documents[document.documentID] = document.data()
                }
                completion(documents)
            }
        }
    }
    
    static func readSingleDocument(collection: String, id: String, completion: @escaping (([String: Any]) -> Void)) {
        db.collection(collection).whereField("id", isEqualTo: id).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                var singleDocument: [String: Any] = [:]
                for document in querySnapshot!.documents {
                    singleDocument = document.data()
                    completion(singleDocument)
                }
            }
        }
    }
    
    static func readSingleDocument<T: Equatable>(type: T.Type , collection: String, data: [String: Any], completion: @escaping (([String: Any]) -> Void)) {
        var singleDocument: [String: Any] = [:]
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let docData = document.data()
                    if isContains(type: T.self, data: data, docData: docData) {
                        singleDocument = docData
                        completion(singleDocument)
                    }
                }
            }
        }
    }
    
    private static func isContains<T: Equatable>(type: T.Type, data: [String: Any], docData: [String: Any]) -> Bool {
        let isContains = docData.contains(where: { (key, value) -> Bool in
            for singlePair in data {
                guard let typedValue = value as? T else { return false }
                guard let singlePairTypedValue = singlePair.value as? T else { return false }
                if singlePair.key == key && singlePairTypedValue == typedValue {
                    return true
                }
            }
            return false
        })
        return isContains
    }
    
    static func getDoctorFromSessionDataValues(complition: @escaping ((Doctor) -> Void)) {
        FirebaseFirestoreInteractor.readSingleDocument(type: String.self, collection: "users", data: [
            "email" : SessionData.AuthEmail.getValue() ?? "",
            "password" : SessionData.AuthPassword.getValue() ?? ""
        ]) { (recieved) in
            guard let id = recieved["id"] as? String else { return }
            
            FirebaseFirestoreInteractor.readSingleDocument(collection: "doctors", id: id) { (recieved) in
                let doctor = Doctor(dictionary: recieved)
                complition(doctor)
            }
        } 
    }
    
    static func getPatients(complition: @escaping (([Patient]) -> Void)) {
        FirebaseFirestoreInteractor.readAllDocuments(collection: "patients") { (recieved) in
            var patients: [Patient] = []
            for value in recieved.values {
                guard let patientData = value as? [String: Any] else { return }
                let patient = Patient(dictionary: patientData)
                patients.append(patient)
            }
            complition(patients)
        }
    }
    
}
