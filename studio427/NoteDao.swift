//
//  MyDao.swift
//  testall
//
//  Created by 祁达方 on 15/10/15.
//  Copyright © 2015年 祁达方. All rights reserved.
//

import Foundation

///本地数据库使用的演示
class NoteDao {
    
    static var me:NoteDao!
    
    var db:COpaquePointer = nil
    let DBFILE_NAME = "NotesList.sqlite3"
    var writableDBPath:String = "";
    var cpath:[CChar]?;
    
    static func instance() -> NoteDao{
        if(me == nil){
            me = NoteDao().start();
        }
        return me;
    }
    
    func start() -> NoteDao{
        
        writableDBPath = self.applicationDocumentsDirectoryFile()
        cpath = writableDBPath.cStringUsingEncoding(NSUTF8StringEncoding)
        
        if sqlite3_open(cpath!, &db) != SQLITE_OK {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            let sql = "CREATE TABLE IF NOT EXISTS Note (id INTEGER PRIMARY KEY, content TEXT)"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
            
            if (sqlite3_exec(db,cSql!, nil, nil, nil) != SQLITE_OK) {
                sqlite3_close(db)
                assert(false, "建表失败。")
            }
            sqlite3_close(db)
        }
        
        return self
    }
    
    func applicationDocumentsDirectoryFile() ->String {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent(DBFILE_NAME) as String
        NSLog("path : %@", path)
        return path
    }
    
    func insert(content: String){
        
        let writableDBPath = self.applicationDocumentsDirectoryFile()
        let cpath = writableDBPath.cStringUsingEncoding(NSUTF8StringEncoding)
        
        //添数据
        let sql = "INSERT INTO note (content) VALUES (?)"
        let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
        
        var statement:COpaquePointer = nil
        
        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                let cContent = content.cStringUsingEncoding(NSUTF8StringEncoding)
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, cContent!, -1, nil)//cContent改为cContent!
                //执行插入
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    assert(false, "插入数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
    }
    
    func select() -> NSMutableArray{
        let result:NSMutableArray = NSMutableArray();
        
        //查数据
        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            let sql = "SELECT id,content FROM Note"
            let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
            
            var statement:COpaquePointer = nil
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                //执行
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    let t = sqlite3_column_int(statement, 0);
                    let id = Int(t);
                    let bufContent = UnsafePointer<Int8>(sqlite3_column_text(statement, 1))
                    let strContent = String.fromCString(bufContent)!
                    
                    let n:Note = Note();
                    n.id = id;
                    n.content = strContent;
                    
                    result.addObject(n);
                }
                
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
        return result;
    }
    
    func update(id: Int, content:String){
        //改数据
        let sql = "update note set content = ? where id = ?"
        let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
        
        var statement:COpaquePointer = nil
        
        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, content, -1, nil);
                sqlite3_bind_int(statement, 2, Int32(id));
                
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    assert(false, "修改数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
    }
    
    func delete(id: Int){
        //删数据
        let sql = "delete from note where id = ?"
        let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
        
        var statement:COpaquePointer = nil
        
        if (sqlite3_open(cpath!, &db) != SQLITE_OK) {
            sqlite3_close(db)
            assert(false, "数据库打开失败。")
        } else {
            //预处理过程
            if sqlite3_prepare_v2(db, cSql!, -1, &statement, nil) == SQLITE_OK {
                
                //绑定参数开始
                sqlite3_bind_text(statement, 1, String(id), -1, nil)
                
                if (sqlite3_step(statement) != SQLITE_DONE) {
                    assert(false, "删除数据失败。")
                }
            }
            sqlite3_finalize(statement)
            sqlite3_close(db)
        }
        
    }
}
