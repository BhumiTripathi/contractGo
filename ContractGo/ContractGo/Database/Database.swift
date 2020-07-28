//
//  Database.swift
//  test
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 manish. All rights reserved.
//

import UIKit
import SQLite3

let aStrDBName = DATABASE_NAME


class Database: NSObject {

    
    var db: OpaquePointer? = nil
    
    var statement: OpaquePointer? = nil
    
    
    // MARK: Shared Utility
    class var sharedInstance: Database {
        struct Static {
            static var instance = Database()
        }
        
    return Static.instance
    }
    
     func getDatabasePath() -> String {
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let destinationPath = doumentDirectoryPath.appendingPathComponent(aStrDBName)
        
      //  print("destinationPath == \(destinationPath)")
        return destinationPath
    }
    
    func createEditableCopyOfDatabaseIfNeeded(failure complitionFailure: (()-> Void)) {
        let fileManger = FileManager.default
        
        let sourcePath = Bundle.main.path(forResource: "cap", ofType: "db")

       // let dbPath = Database.createPath(dbname: aStrDBName)
        
        let dbPath = Database.sharedInstance.getDatabasePath()

        if fileManger.fileExists(atPath: dbPath) {
            //Success
             let successBackup = addSkipBackupAttributeToItem(at: URL(fileURLWithPath: dbPath))
            print(successBackup)
            
        }else{
            //Failure
            
            do {
                try fileManger.copyItem(atPath: sourcePath!, toPath: dbPath)
            }catch{
                print(error.localizedDescription)
                
                // Alert if file is not exist
                if !error.localizedDescription.contains("already exists") {
                    print(error.localizedDescription)
                    
                    complitionFailure()
                    
                }else{
                    
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    
    private func sqliteOpenAndPrepare(query: String, success complition: (()-> Void), fail complitionFailure: ((String)-> Void)) {
        
//        let dbPath = Database.createPath(dbname: aStrDBName)
          let dbPath = Database.sharedInstance.getDatabasePath()
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    complition()
                }else{
                    let errmsg = String(cString: sqlite3_errmsg(db))
                    print("\(errmsg)")
                    complitionFailure(errmsg)
                }
                
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error preparing insert: \(errmsg)")
                complitionFailure(errmsg)
                
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)
        }
        
    }
    
     func insert(query: String, success complition: (()-> Void), failure complitionFailure:((String)-> Void)) {

        
       self.sqliteOpenAndPrepare(query: query, success: { 
        // Succes
        
        complition()
        
       }, fail: {_ in 
        // Failure
        
        let errmsg = String(cString: sqlite3_errmsg(db))
        complitionFailure(errmsg)
       })
        
        if sqlite3_finalize(statement) == SQLITE_OK {
            
            if sqlite3_close(db) == SQLITE_OK {
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                complitionFailure(errmsg)

            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)

        }
       
    }
    
     func update(query: String, success complition: (()-> Void), failure complitionFailure: @escaping ((String)-> Void)) {

        
        self.sqliteOpenAndPrepare(query: query, success: {
            // Succes
            
            complition()
            
        }, fail: {_ in 
            // Failure
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)
        })
        
        
        if sqlite3_finalize(statement) == SQLITE_OK {
            
            if sqlite3_close(db) == SQLITE_OK {
            }else{
                sqlite3_errmsg(db)
                
            }
        }else{
            sqlite3_errmsg(db)
            
        }
        
    }
    
     func delete(query: String, success complition: (()-> Void), failure complitionFailure: @escaping ((String)-> Void)) {

        
        
        self.sqliteOpenAndPrepare(query: query, success: {
            // Success
            
            complition()
            
        }, fail: {_ in 
            // Failure
            
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)
        })
        
        
        if sqlite3_finalize(statement) == SQLITE_OK {
            
            if sqlite3_close(db) == SQLITE_OK {
            }else{
                sqlite3_errmsg(db)
                
            }
        }else{
            sqlite3_errmsg(db)
            
        }
        
    }
    
     func getRecordCount(query: String, success complition: ((Int)-> Void), failure complitionFailure: ((String)-> Void)) {
        
        var count: Int = 0
        
//        let dbPath = Database.createPath(dbname: aStrDBName)
        let dbPath = Database.sharedInstance.getDatabasePath()
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_ROW {
                    count = Int(sqlite3_column_int(statement, 0))
                    complition(count)

                }

            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                complitionFailure(errmsg)
                
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)
        }
        
        
        if sqlite3_finalize(statement) == SQLITE_OK {
            
            if sqlite3_close(db) == SQLITE_OK {
            }else{
                sqlite3_errmsg(db)
            }
        }else{
            sqlite3_errmsg(db)
        }
        
    }
    
    func getRecordAvegare(query: String, success complition: ((Int)-> Void), failure complitionFailure: ((String)-> Void)) {
        
        var avg: Int = 0
        
//        let dbPath = Database.createPath(dbname: aStrDBName)

        let dbPath = Database.sharedInstance.getDatabasePath()
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_ROW {
                    avg = Int(sqlite3_column_int(statement, 0))
                    complition(avg)
                    
                }
                
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                complitionFailure(errmsg)
                
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)
        }
        
        
        if sqlite3_finalize(statement) == SQLITE_OK {
            
            if sqlite3_close(db) == SQLITE_OK {
            }else{
                sqlite3_errmsg(db)
            }
        }else{
            sqlite3_errmsg(db)
        }
        
    }

    
    func createTable(query: String, success complition: (()-> Void), failure complitionFailure: ((String)-> Void)) {
        
       // let dbPath = Database.createPath(dbname: aStrDBName)
        let dbPath = Database.sharedInstance.getDatabasePath()
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_exec(db, query, nil, nil, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    complition()
                }

            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                complitionFailure(errmsg)
                
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)
        }
        
        
        if sqlite3_finalize(statement) == SQLITE_OK {
            
            if sqlite3_close(db) == SQLITE_OK {
            }else{
               
            }
        }else{
            
        }
        
    }
    
    // You will have to change in this code as per requirement
    func insertDatinBulk(query: String, array : [[String:AnyObject]], fail complitionFailure: ((String)-> Void)) {

    
        if (array.count > 0) {
           
            var errMsg:UnsafeMutablePointer<Int8>? = nil
          
            if sqlite3_exec(db, "BEGIN TRANSACTION", nil, nil, &errMsg) == SQLITE_OK {
                
                print("Insert Data is \(array)")
                
                let cSql = query.cString(using: String.Encoding.utf8)
                var result:CInt=0
               // let dbPath = Database.createPath(dbname: aStrDBName)
                let dbPath = Database.sharedInstance.getDatabasePath()
                let dbpathEncoded = dbPath.cString(using: String.Encoding.utf8)
                
                if sqlite3_open(dbpathEncoded, &db) == SQLITE_OK {
                    
                    if sqlite3_prepare_v2(db, cSql, -1, &statement, nil) == SQLITE_OK {
                        
                        for item in array
                        {
                            
                            let itemName = item["name"] as! NSString
                            sqlite3_bind_text(statement, 1, itemName.utf8String, -1, nil)
                            sqlite3_bind_int(statement, 2, Int32(123))
                            
                            result = sqlite3_step(statement)
                            
                            if(result != SQLITE_DONE)
                            {
                                print("failed to insert")
                            }
                            else
                            {
                                print("inserted")
                                break
                            }
                            
                            sqlite3_clear_bindings(statement);
                            sqlite3_reset(statement);
                        }
                        
                    }else{
                        let errmsg = String(cString: sqlite3_errmsg(db))
                        print("error preparing insert: \(errmsg)")
                        
                        complitionFailure(errmsg)
                        
                    }
                }else{
                    let errmsg = String(cString: sqlite3_errmsg(db))
                    
                    complitionFailure(errmsg)
                }
                
                
                sqlite3_exec(db, "COMMIT TRANSACTION", nil, nil, &errMsg)
                sqlite3_exec(db, "END TRANSACTION",  nil, nil, &errMsg)
                sqlite3_finalize(statement)
                sqlite3_close(statement)
                
            }
            

        }
    }
    
    
    func getData(query: String, fail complitionFailure: ((String)-> Void)) -> [[String:AnyObject]] {
        
        var result = [[String:AnyObject]]()
        
       // let dbPath = Database.createPath(dbname: aStrDBName)
        let dbPath = Database.sharedInstance.getDatabasePath()
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    
                    let count: Int32 = sqlite3_column_count(statement)
                   // print(count)
                    
                    var columnNAme: String = ""
                    
                    var aDict = [AnyHashable: Any]()
                    
                    for i in 0..<count {
                        
                        
                        /*
                         #define SQLITE_INTEGER  1
                         #define SQLITE_FLOAT    2
                         #define SQLITE_BLOB     4
                         #define SQLITE_NULL     5
                         #ifdef SQLITE_TEXT
                         # undef SQLITE_TEXT
                         #else
                         # define SQLITE_TEXT     3
                         #endif
                         #define SQLITE3_TEXT     3
                         
                         
                         */
                        
                        let columnName = sqlite3_column_name(statement, i)
                        columnNAme = String(cString: columnName!)

                        if sqlite3_column_type(statement, i) == SQLITE_TEXT  {
                            
                            let name = sqlite3_column_text(statement, i)
    
                            aDict[columnNAme] = String(cString: name!)
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_INTEGER {
                            
                            let aintValue = sqlite3_column_int(statement, i)
                            
                            aDict[columnNAme] = Int(aintValue)
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_BLOB {

                            let len = sqlite3_column_bytes(statement, i)

                            let aBolbValue = sqlite3_column_blob(statement, i)
                            
                            aDict[columnNAme] = NSData(bytes: aBolbValue, length: Int(len))
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_FLOAT {
                            
                            let aFloatValue = sqlite3_column_double(statement, i)
                            
                            aDict[columnNAme] = Float(aFloatValue)
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_NULL {
                            
                           
                        }
                    }
                    result.append(aDict as! [String : AnyObject])

                }
                
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                complitionFailure(errmsg)
                
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)
        }
        
        return result
    }
    
    func addSkipBackupAttributeToItem(at URL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: URL.path) {
                let error: Error? = nil
                let success = try NSURL(string: URL.absoluteString)?.setResourceValue(Int(true), forKey: .isExcludedFromBackupKey)
                if success == nil {
                    print("Error excluding \(URL.lastPathComponent) from backup \(String(describing: error))")
                }
                return (success != nil)
            }
        }
        catch {
        }
        return false
    }
}



///Volumes/DATA/Mohsinali bakcup/Desktop/Live Projects/Tinu_Dahiya/Quote_Guru/iOS/QuoteGuru/Database/Database.swift:481:21: Constant 'success' inferred to have type '()?', which may be unexpected

