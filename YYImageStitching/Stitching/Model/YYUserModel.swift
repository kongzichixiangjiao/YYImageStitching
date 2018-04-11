//
//  YYUserModel.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/10.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import SQLite

@objcMembers class YYUserModel {
    var iD: Int64 = 0
    var userId: String = "" {
        didSet {
            self.iD = userId.int64
        }
    }
    var name: String = ""
    var age: Int = 0
    var gender: Int = 0
    
    var userName = ""
    var passwrod: String = ""
    var phone: String = ""
    var authCode: String = ""
    var email: String = ""

    let iD_e = Expression<Int64>("iD")
    let userId_e = Expression<String>("userId")
    let userName_e = Expression<String>("userName")
    let passwrod_e = Expression<String>("passwrod")
    let name_e = Expression<String>("name")
    
    lazy var userTable: Table = {
        return Table("YYUserModel")
    }()
    
    
    func createUserTable() {
        
        try! YYSQLite.share.db?.run(userTable.create(ifNotExists: true, block: { (table) in
            table.column(iD_e, primaryKey: true)
            table.column(userName_e)
            table.column(userId_e)
            table.column(passwrod_e)
            table.column(name_e)
        }))
        
//        let insert2 = users.insert(name <- "Amazing7", email <- "360898864@qq.com")
//        let rowid2 = (try! db?.run(insert2))!
//
//
//        for user in (try! db?.prepare(users))! {
//            print("Query:id: \(user[iD]), name: \(user[name]), email: \(user[email])")
//        }
//
//
//        let update = users.filter(iD == rowid)
//        try! db?.run(update.update(email <- email.replace("foxmail", with: "qq")))
//
//        for user in (try! db?.prepare(users.filter(name == "究极死胖兽")))! {
//            print("Update:id: \(user[iD]), name: \(user[name]), email: \(user[email])")
//        }
//
//
//        try! db?.run(users.filter(iD == rowid2).delete())
//        for user in (try! db?.prepare(users))! {
//            print("Delete:id: \(user[iD]), name: \(user[name]), email: \(user[email])")
//        }
    }
    
    func insertUser() -> Bool {
//        addColums()
        let insert = userTable.insert(self.iD_e <- self.iD, self.userId_e <- self.userId, userName_e <- self.userName, passwrod_e <- self.passwrod, self.name_e <- self.name)
        do {
            try YYSQLite.share.db?.run(insert)
            return true
        } catch {
            return false
        }
    }
    
    func updateUser() -> Bool {
        let update = userTable.filter(self.userId.int64 == self.iD_e)
        do {
            try YYSQLite.share.db?.run(update.update(self.iD_e <- self.iD, self.userId_e <- self.userId, userName_e <- self.userName, passwrod_e <- self.passwrod, self.name_e <- self.name))
            return true
        } catch {
            return false
        }
    }
    
    func searchUser() -> YYUserModel? {
        for user in (try! YYSQLite.share.db?.prepare(userTable.filter(self.userId.int64 == self.iD_e)))! {
            print("iD = ", user[iD_e], "name = ", user[name_e], "userName = ", user[userName_e], "password = ", user[passwrod_e])
            let model = YYUserModel()
            model.iD = user[iD_e]
            model.name = user[name_e]
            model.userName = user[userName_e]
            model.passwrod = user[passwrod_e]
        }
        return nil
    }
    
//    func addColums() {
//        try! YYSQLite.share.db?.run(userTable.addColumn(self.name_e, defaultValue: ""))
//    }
    
}
