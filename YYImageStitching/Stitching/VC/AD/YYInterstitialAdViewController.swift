//
//  YYAdViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/22.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import GoogleMobileAds

class YYInterstitialAdViewController: YYBaseViewController {

    var interstitial: GADInterstitial!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        interstitial = createAndLoadInterstitial()
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Ad wasn't ready")
            interstitial = createAndLoadInterstitial()
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        // ca-app-pub-3940256099942544/4411468910 // test
        // ca-app-pub-3164648306313935/8109579681 // 横幅
        // ca-app-pub-3164648306313935/4321952883 // 插页式
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3164648306313935/4321952883")
        interstitial.delegate = self
        let r = GADRequest()
        interstitial.load(r)
        return interstitial
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension YYInterstitialAdViewController: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        ad.present(fromRootViewController: self)
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        
    }
}
