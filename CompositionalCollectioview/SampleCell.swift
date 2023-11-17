//
//  SampleCell.swift
//  CompositionalCollectioview
//
//  Created by 신진우 on 11/16/23.
//

import UIKit

class SampleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(data:AppleFramework) {
        
        titleLabel.text = data.name
        imageView.image = UIImage(named: data.imageName)
    }
    
}
