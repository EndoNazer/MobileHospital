//
//  FirebaseStorageInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 21.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation
import FirebaseStorage

class FirebaseStorageInteractor {
    
    static let storage = Storage.storage()
    static let storageRef = storage.reference()
    
    static func addFileToStorage(url: URL, fileName: String, folderName: String) {
        let uploadTask = storageRef.child("\(folderName)/\(fileName)").putFile(from: url, metadata: nil) { (metadata, err) in
            if err != nil {
                print("err")
            }
        }
        uploadTask.observe(.success) { snapshot in
            print("AWESOME")
        }

        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    print("object not found")
                    break
                case .unauthorized:
                    print("User doesn't have permission to access file")
                    break
                case .cancelled:
                    print("User canceled the upload")
                    break
                case .unknown:
                    print("Unknown error occurred, inspect the server response")
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
        
    }
    
}
