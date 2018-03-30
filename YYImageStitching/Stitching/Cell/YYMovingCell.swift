//
//  YYStitchingCell.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYMovingCell: UICollectionViewCell {

    static let identifier = "YYMovingCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectedButton: UIButton!
    
    @IBOutlet weak var topSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    @IBOutlet weak var leftSpace: NSLayoutConstraint!
    @IBOutlet weak var rightSpace: NSLayoutConstraint!
    
    var model: YYImageModel! {
        didSet {
            selectedButton.isSelected = model.isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupEdit(isEdit: Bool) {
        selectedButton.isHidden = !isEdit
    }

}


