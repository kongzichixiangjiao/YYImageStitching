//
//  YYTViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/11.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYWheelViewController: YYBaseCollectionViewController {
    
    var velocity: CGFloat = 0
    var count: Int = 0
    var timer: Timer!
    
    var stop: Bool = false
    
    lazy var sectorView: YYSectorView = {
        let v = YYSectorView(frame: CGRect(x: 0, y: 0, width: 350, height: 350), isNei: false)
        v.backgroundColor = UIColor.orange
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 350 / 2
        return v
    }()
    
    lazy var sectorView1: YYSectorView = {
        let v = YYSectorView(frame: CGRect(x: 0, y: 0, width: 236, height: 236), isNei: true)
        v.backgroundColor = UIColor.yellow
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 236 / 2
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(sectorView)
        sectorView.yy_addPanGesture(target: self, action: #selector(pan(sender:)))
        sectorView1.yy_addTapGesture(target: self, numberOfTapsRequired: 1, action: #selector(tap(sender:)))
        
        self.view.addSubview(sectorView1)
        sectorView1.yy_addPanGesture(target: self, action: #selector(pan1(sender:)))
        sectorView1.yy_addTapGesture(target: self, numberOfTapsRequired: 1, action: #selector(tap1(sender:)))
        
        sectorView1.center = sectorView.center
        
//        registerCell(nibName: YYCircleCell.identifier)

//        collectionView.collectionViewLayout = CollectionViewCircleLayout(withConfiguration: CircleLayoutConfiguration(withCellSize: CGSize(width: 140, height: 140), spacing: 50, offsetX: 0, offsetY: 200))
        
        timer = Timer(timeInterval: 0.08, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
        timer.fire()
    }
    
    @objc func timerAction() {
        if sectorView.stop { return }
        if sectorView1.stop { return }
        self.sectorView.transform = self.sectorView.transform.rotated(by: 0.03)
        
        self.sectorView1.transform = self.sectorView1.transform.rotated(by: -0.04)
    }
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        self.sectorView.layer.speed = 1
        count += 1
        
        if count % 5 == 0 {
            sectorView.transform = sectorView.transform.rotated(by: -2 *
            CGFloat.pi * 1 / 4)
        }
        if sender.state == .ended {
            sectorView.stop = false
        }
        return
        if sender.state == .began {
            let v = sender.velocity(in: self.view)
            print(v.y)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.sectorView.transform = self.sectorView.transform.rotated(by: 2 *
                    CGFloat.pi * 1 / 4)
            }, completion: nil)
        }
        return
        if sender.state == .changed {
            let v = sender.velocity(in: self.view)
            print(v.y)
            if (v.y > 0) {
                
                if count % 5 == 0 {
                    sectorView.transform = sectorView.transform.rotated(by: 2 *
                        CGFloat.pi * 1 / 4)
                }
            } else {
                if count % 5 == 0 {
                    sectorView.transform = sectorView.transform.rotated(by: -2 *
                        CGFloat.pi * 1 / 4)
                }
            }
            velocity += v.y
        }
    }
    
    @objc func pan1(sender: UIPanGestureRecognizer) {
        self.sectorView1.layer.speed = 1
        
        count += 1
        
        if count % 5 == 0 {
            sectorView1.transform = sectorView1.transform.rotated(by: -2 *
                CGFloat.pi * 1 / 4)
        }
        if sender.state == .ended {
            sectorView1.stop = false
        }
        return
        
        var startP = CGPoint.zero
        var endP = CGPoint.zero
        
        if sender.state == .began {
            let v = sender.velocity(in: self.view)
//            print(v.y)
            startP = sender.translation(in: sectorView1)
            
//            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
//            animation.fromValue = 0
//            animation.toValue = CGFloat.pi * 2
//            animation.duration = 0.5
//            animation.repeatCount = 20
//            animation.isRemovedOnCompletion = true
//            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//            animation.delegate = self
//            self.sectorView1.layer.add(animation, forKey: "z")
//            sectorView1.transform = sectorView1.transform.rotated(by: CGFloat.pi * CGFloat(arc4random_uniform(4)))

//            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
//                self.sectorView1.transform = self.sectorView1.transform.rotated(by: -2 *
//                    CGFloat.pi * 1 / 4)
//            }, completion: nil)
            
        }
        
        if (sender.state == .ended) {
            
            let v = sender.velocity(in: self.view)
            endP = sender.translation(in: sectorView1)
            print(endP.y - startP.y)
            print("y == ", v.y)
            if (v.y > 600 && (endP.y - startP.y > 30 || endP.x - startP.x > 30)) {
                let animation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.fromValue = 0
                animation.toValue = CGFloat.pi * 2
                animation.duration = 0.3
                animation.repeatCount = 5
                //            animation.isRemovedOnCompletion = true
                //            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                animation.delegate = self
                self.sectorView1.layer.add(animation, forKey: "z")
                sectorView1.transform = sectorView1.transform.rotated(by: CGFloat.pi * CGFloat(arc4random_uniform(4)))
            } else if (v.y > 600 && endP.y - startP.y > -100) {
                
            }
        }
        
        if sender.state == .changed {
            let v = sender.velocity(in: self.view)
//            print(v.y)
            if (v.y > 0) {
                    if count % 5 == 0 {
                        sectorView1.transform = sectorView1.transform.rotated(by: 2 *
                            CGFloat.pi * 1 / 4)
                    }
            } else {
                if count % 5 == 0 {
                    sectorView1.transform = sectorView1.transform.rotated(by: -2 *
                        CGFloat.pi * 1 / 4)
                }
            }
            velocity += v.y
        }
        count += 1
    }
    
    @objc func tap1(sender: UITapGestureRecognizer) {
//        self.stop = !self.stop
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        self.sectorView1.layer.speed = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        timer.invalidate()
    }
    
}

extension YYWheelViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    
    }
}

extension YYWheelViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYCircleCell.identifier, for: indexPath) as! YYCircleCell
        cell.textLabel.backgroundColor = UIColor.clear
        switch indexPath.row + 1 {
        case 1:
            cell.textLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 4 / 4)
            return cell
        case 2:
            cell.textLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 3 / 4)
            return cell
        case 3:
            cell.textLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 1 / 4)
            return cell
        case 4:
            cell.textLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 0 / 4)
            return cell
        case 5:
            cell.textLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 1 / 4)
            return cell
        case 6:
            cell.textLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3 / 4)
            return cell
        default:
            cell.textLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("22")
    }
    
}
