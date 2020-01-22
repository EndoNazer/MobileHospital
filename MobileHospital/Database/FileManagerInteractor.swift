//
//  FileManagerInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 22.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class FileManagerInteractor {
    
    static func saveToDirectory(data: [String: Any], fileName: String) -> URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = directory.appendingPathComponent(fileName)
        
        var text = ""
        for str in data {
            text += str.key + " - "
            if let value = str.value as? String {
                text += value
            } else if let value = str.value as? [String] {
                for item in value {
                    text += item + " "
                }
            }
            text += "\n"
        }
        
        writeToFile(url: fileURL, text: text)
        
        return fileURL
    }
    
    static func writeToFile(url: URL, text: String) {
        do {
            try text.write(to: url, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error in writing")
        }
    }
    
    static func readFile(url: URL) {
        do {
            let getText = try String(contentsOf: url, encoding: .utf8)
            print(getText)
        }
        catch {
            print("Error in reading")
        }
    }
    
}
