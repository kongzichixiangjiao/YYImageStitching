//
//  YYBorderToolsView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYBorderToolsView: UIView {
    
    static let height: CGFloat = 100
    
    typealias BorderToolsViewDidSelectedColorHanlder = (_ color: UIColor) -> ()
    var borderToolsViewDidSelectedColorHanlder: BorderToolsViewDidSelectedColorHanlder!
    
    @IBOutlet weak var backProgressView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var borderWidth: CGFloat! {
        didSet {
            self.progressView.currentPointX = borderWidth 
        }
    }
    
    private var colors: [UIColor] = []
    
    lazy var progressView: YYProgressView = {
        let v = YYProgressView(frame: CGRect.zero)
        v.progressViewHandler = progressViewHandler
        return v
    }()
    
    lazy var progressViewHandler: YYProgressView.YYProgressViewHandler = {
        [weak self] width, type in
        if let weakSelf = self {
            weakSelf.progressViewHandler(width, type)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        
        colors = [UIColor.orange, UIColor.black, UIColor.white, UIColor.darkText, UIColor.lightGray, UIColor.lightText, UIColor.brown, UIColor.cyan]
        
        initViews()
    }
    
    private func initViews() {
        backProgressView.addSubview(progressView)
        progressView.yy_addConstraint(toItem: backProgressView)
        
        collectionView.register(UINib(nibName: YYBorderToolsColorCell.identifier, bundle: nil), forCellWithReuseIdentifier: YYBorderToolsColorCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        let layout = YYBorderToolsColorFlowLayout()
        collectionView.collectionViewLayout = layout
    }
}

extension YYBorderToolsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYBorderToolsColorCell.identifier, for: indexPath) as! YYBorderToolsColorCell
        cell.contentView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = self.colors[indexPath.row]
        progressView.progressColor = color
        borderToolsViewDidSelectedColorHanlder(color)
    }
}
