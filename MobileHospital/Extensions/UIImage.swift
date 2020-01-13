//
//  UIImage.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

extension UIImage {
    func downloaded(from url: URL, complition: @escaping ((UIImage) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let img = UIImage(data: data)
                else { return }
            complition(img)
        }.resume()
    }
    func downloaded(from link: String, complition: @escaping ((UIImage) -> Void)) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, complition: complition)
    }
}
