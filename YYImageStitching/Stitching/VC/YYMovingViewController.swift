//
//  ViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Photos

class YYMovingViewController: YYBaseCollectionViewController {
    
    enum MoveCellType {
        case MOVE, SELECTED, NONE
    }
    
    var longPressGesture: UILongPressGestureRecognizer!
    var moveCellType: MoveCellType! = .NONE
    var indexPathMove: IndexPath! = IndexPath(item: 1000, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLongPressGesture()
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

extension YYMovingViewController {
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceModel = self.dataSource[sourceIndexPath.row]
        dataSource.remove(at: sourceIndexPath.row)
        dataSource.insert(sourceModel, at: destinationIndexPath.row)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let version = Double(UIDevice.current.systemVersion) {
            if (version < 9.0) {
                moveCollectionViewCell(indexPath: indexPath)
            }
        }
    }
    
    // iOS8 适配
    func moveCollectionViewCell(indexPath: IndexPath) {
        if indexPath == indexPathMove {
            _ = collectionView.cellForItem(at: indexPath) as! YYMovingCell
            moveCellType = .NONE
            indexPathMove = IndexPath(item: 1000, section: 0)
            collectionView.endInteractiveMovement()
        } else {
            switch moveCellType! {
            case .SELECTED:
                _ = collectionView.cellForItem(at: indexPath) as! YYMovingCell
                collectionView.moveItem(at: indexPathMove, to: indexPath)
                moveCellType = .NONE
                indexPathMove = IndexPath(item: 1000, section: 0)
                collectionView.endInteractiveMovement()
                break
            case .MOVE:
                break
            case .NONE:
                _ = collectionView.cellForItem(at: indexPath) as! YYMovingCell
                indexPathMove = indexPath
                moveCellType = .SELECTED
                collectionView.beginInteractiveMovementForItem(at: indexPath)
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return proposedIndexPath
    }
    
}

