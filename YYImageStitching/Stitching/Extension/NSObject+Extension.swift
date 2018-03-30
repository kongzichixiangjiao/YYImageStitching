//
//  NSObject+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

public extension NSObject{
    
    public class var ga_nameOfClass: String {
        // NSStringFromClass(self) 获得的是项目名.类名
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var ga_nameOfClass: String{
        
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
//    public class var ga_nameOfGenericityClass: String {
//        let a = self.classForKeyedUnarchiver()
//        return a. as! String
//    }
//
//    public var ga_nameOfGenericityClass: String {
//        return self.classForCoder().components(separatedBy: "<").first!
//    }
    
    
}


