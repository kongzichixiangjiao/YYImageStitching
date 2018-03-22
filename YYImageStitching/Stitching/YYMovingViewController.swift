//
//  ViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Photos

class YYMovingViewController: YYPickerImageViewController {
    
    enum MoveCellType {
        case MOVE, SELECTED, NONE
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var longPressGesture: UILongPressGestureRecognizer!
    var moveCellType: MoveCellType! = .NONE
    var indexPathMove: IndexPath! = IndexPath(item: 1000, section: 0)
    
    var dataSource: [YYImageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        
        addLongPressGesture()
    }
    
    private func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: YYStitchingCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: YYStitchingCell.identifier)
    }
    
    private func addLongPressGesture() {
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        self.collectionView.addGestureRecognizer(longPressGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            /// 通过indexPathForItemAtPoint这个方法获取cell， 通过这个locationInView方法获取点击的cell
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            //开始移动
            if (collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)) {
                print("true")
            } else {
                print("false")
            }
            break
        case UIGestureRecognizerState.changed:
            //移动中
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
            break
        case UIGestureRecognizerState.ended:
            //结束移动
            collectionView.endInteractiveMovement()
            break
        default:
            collectionView.cancelInteractiveMovement()
            break
        }
    }
}

extension YYMovingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        print("1")
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        print("2")
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceModel = self.dataSource[sourceIndexPath.row]
        dataSource.remove(at: sourceIndexPath.row)
        dataSource.insert(sourceModel, at: destinationIndexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let version = Double(UIDevice.current.systemVersion) {
            if (version < 9.0) {
                moveCollectionViewCell(indexPath: indexPath)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return proposedIndexPath
    }
    
    // iOS8 适配
    func moveCollectionViewCell(indexPath: IndexPath) {
        if indexPath == indexPathMove {
            _ = collectionView.cellForItem(at: indexPath) as! YYStitchingCell
            moveCellType = .NONE
            indexPathMove = IndexPath(item: 1000, section: 0)
            collectionView.endInteractiveMovement()
        } else {
            switch moveCellType! {
            case .SELECTED:
                _ = collectionView.cellForItem(at: indexPath) as! YYStitchingCell
                collectionView.moveItem(at: indexPathMove, to: indexPath)
                moveCellType = .NONE
                indexPathMove = IndexPath(item: 1000, section: 0)
                collectionView.endInteractiveMovement()
                break
            case .MOVE:
                break
            case .NONE:
                _ = collectionView.cellForItem(at: indexPath) as! YYStitchingCell
                indexPathMove = indexPath
                moveCellType = .SELECTED
                collectionView.beginInteractiveMovementForItem(at: indexPath)
                break
            }
        }
    }
    
}

