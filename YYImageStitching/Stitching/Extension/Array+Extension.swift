//
//  Array+Extension.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

extension Array where Element: Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}

/*
 let array2 = ["sunny","cloudy","apple orange"]
 array2.countWords() // 4
 */
extension Collection where Element == String {
    func countWords() -> Int {
        return reduce(0) {
            let components = $1.components(separatedBy: .whitespacesAndNewlines)
            return $0 + components.count
        }
    }
}
