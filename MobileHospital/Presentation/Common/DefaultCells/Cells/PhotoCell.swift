//
//  ProfilePhotoCell.swift
//  MobileHospital
//
//  Created by Даниил on 13.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var cellModel: PhotoCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
        configureRadius()
    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func configureRadius() {
        avatarImageView.cornerRadius = avatarImageView.frame.height / 2
    }
    
    private func configureWith(image: UIImage) {
        self.avatarImageView.image = image
    }
    
}

//MARK: - TableCellConfigurable

extension PhotoCell: TableCellConfigurable {
    
    func config(cellModel: TableCellModel) {
        guard let cellModel = cellModel as? PhotoCellModel else { return }
        self.cellModel = cellModel
        configureWith(image: cellModel.image)
    }
    
}
