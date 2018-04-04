//
//  YYSelectedFiltersView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYSelectedFiltersView: UIView {

    var filters: [FilterEnum] = [.chongyin, .danse, .heibai, .huaijue, .laohuang, .leng, .sediao, .suiyue, .tuise]

    typealias FiltersToolsViewHandler = (_ type: FilterEnum) -> ()
    var filtersToolsViewHandler: FiltersToolsViewHandler!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.yy_register(nibName: YYFilterStringCell.identifier)
        let layout = YYFilterStringFlowLayout()
        collectionView.collectionViewLayout = layout
    }
}

extension YYSelectedFiltersView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYFilterStringCell.identifier, for: indexPath) as! YYFilterStringCell
        cell.textLabel.text = filters[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filtersToolsViewHandler(filters[indexPath.row])
    }
}
