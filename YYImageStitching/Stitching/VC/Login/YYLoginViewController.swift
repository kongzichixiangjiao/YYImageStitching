//
//  YYLoginViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYLoginViewController: YYBaseCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell(nibName: YYScaleMovingCell.identifier)
        collectionView.collectionViewLayout = CircleLayout()
//        var m1 = YYUserModel()
//        for i in 1..<5 {
//            let m = YYUserModel()
//            m.createUserTable()
//            m.userName = String(i + 2)
//            m.userId = String(i + 2)
//            m.passwrod = String(i + 2)
//            m.name = String(i + 2)
//            m.updateUser()
//            if (i == 2) {
//                m1 = m
//            }
//        }
//
//        m1.searchUser()
//
//        let v = YYSectorView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
//        v.backgroundColor = UIColor.orange
//        self.view.addSubview(v)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: UIButton) {
        yy_appdelegate?.window??.rootViewController = UIStoryboard.yy_main().instantiateInitialViewController()
    }
    
    deinit {
        print("-----------YYLoginViewController--------------")
    }
    
    
}
extension YYLoginViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYScaleMovingCell.identifier, for: indexPath) as! YYScaleMovingCell
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
}
