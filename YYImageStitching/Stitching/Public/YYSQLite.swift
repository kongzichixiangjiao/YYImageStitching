//
//  YYSQLite.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/11.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  数据库使用


import UIKit
import SQLite

enum SQLiteParameter {
    case int64, string
}

class YYSQLite {

    static let s: YYSQLite = YYSQLite()
    
    class var share: YYSQLite {
        return s
    }
    
    var db: Connection? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(path)
        let db = try? Connection("\(path)/yySqlite.db")
        return db
    }
    
    // eg:
    
//    func createTable() {
//        let users = Table("users")
//        let id = Expression<Int64>("id")
//        let name = Expression<String?>("name")
//        let email = Expression<String>("email")
//        
//        try! db?.run(users.create(ifNotExists: true, block: { (table) in
//            table.column(id, primaryKey: true)
//            table.column(name)
//            table.column(email, unique: true)
//        }))
//
//        let insert = users.insert(name <- "究极死胖兽", email <- "scuxiatian@foxmail.com")
//        let rowid = (try! db?.run(insert))!
//        let insert2 = users.insert(name <- "Amazing7", email <- "360898864@qq.com")
//        let rowid2 = (try! db?.run(insert2))!
//        
//        
//        for user in (try! db?.prepare(users))! {
//            print("Query:id: \(user[id]), name: \(user[name]), email: \(user[email])")
//        }
//        
//        
//        let update = users.filter(id == rowid)
//        try! db?.run(update.update(email <- email.replace("foxmail", with: "qq")))
//        
//        for user in (try! db?.prepare(users.filter(name == "究极死胖兽")))! {
//            print("Update:id: \(user[id]), name: \(user[name]), email: \(user[email])")
//        }
//        
//        
//        try! db?.run(users.filter(id == rowid2).delete())
//        for user in (try! db?.prepare(users))! {
//            print("Delete:id: \(user[id]), name: \(user[name]), email: \(user[email])")
//        }
//    }
    
}

/*
 let sqliteContext = SQLiteManager() //如果没有,默认创建数据库及表格
 //插入数据
 sqliteContext.insertData("username", _email: "email@126.com")
 //读取全部数据
 //要想读取指定数据，可以自己自定义转换成其他模型，比如字典+元组，可以根据id查找
 let dataM = sqliteContext.readData()
 print(dataM)
 //更新数据 1 -> 用户id
 sqliteContext.updateData(1, old_name: "oldValue", new_name: "newValue")
 //删除数据
 sqliteContext.delData(1) // 1 -> 用户id
 */

struct SQLiteManager {
    
    private var db: Connection!
    private let users = Table("users") //表名
    private let id = Expression<Int64>("id")      //主键
    private let name = Expression<String>("name")  //列表1
    private let email = Expression<String>("email") //列表2
    
    init() {
        createdsqlite3()
    }
    
    //创建数据库文件
    mutating func createdsqlite3(filePath: String = "/Documents")  {
        
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite3"
        do {
            db = try Connection(sqlFilePath)
            try db.run(users.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(email, unique: true)
            })
        } catch { print(error) }
    }
    
    //插入数据
    func insertData(_name: String, _email: String){
        do {
            let insert = users.insert(name <- _name, email <- _email)
            try db.run(insert)
        } catch {
            print(error)
        }
    }
    
    //读取数据
    func readData() -> [(id: String, name: String, email: String)] {
        var userData = (id: "", name: "", email: "")
        var userDataArr = [userData]
        for user in try! db.prepare(users) {
            userData.id = String(user[id])
            userData.name = user[name]
            userData.email = user[email]
            userDataArr.append(userData)
        }
        return userDataArr
    }
    
    //更新数据
    func updateData(userId: Int64, old_name: String, new_name: String) {
        let currUser = users.filter(id == userId)
        do {
            try db.run(currUser.update(name <- name.replace(old_name, with: new_name)))
        } catch {
            print(error)
        }
        
    }
    
    //删除数据
    func delData(userId: Int64) {
        let currUser = users.filter(id == userId)
        do {
            try db.run(currUser.delete())
        } catch {
            print(error)
        }
    }
}

