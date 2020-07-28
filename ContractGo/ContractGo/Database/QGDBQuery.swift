
//

import UIKit

class DatabaseQuery: NSObject {
    
    
    //Select Query
    func selectDataFromDB(aDictValue:[String : AnyObject],tableName:String,tableKey:String)-> [[String:AnyObject]]  {
        
        let arrData:[[String:AnyObject]]
        
        if aDictValue.isEmpty && tableKey.isEmpty{
            
            print("SELECT * FROM \(tableName)")
            
            arrData = Database().getData(query: "SELECT * FROM \(tableName)") { (error: String) in
                print("Error: \(error)")
            }
            
        }
        else{
            
            print("SELECT * FROM \(tableName) WHERE \(tableKey)='\(aDictValue["\(tableKey)"]!)'")
            
            arrData = Database().getData(query: "SELECT * FROM \(tableName) WHERE \(tableKey)='\(aDictValue["\(tableKey)"]!)'") { (error: String) in
                print("Error: \(error)")
            }
            
        }
        
        return arrData
    }
    
    
    
    //Insert Query
    func insertSAVE_DATA_MASTERToDB(fileName: String, ParentLN: String, price_level: String, discountvalue:String)  {
        
        var strInsertQuery = String()
        strInsertQuery = "INSERT INTO SAVE_DATA_MASTER (FILE_NAME, PARENT_LINE_NUMBER, PRICE_LEVEL, DISCOUNT_VALUE, USER_ID, CREATED_DATE_TIME) VALUES (" + "'\(fileName)'" + ", '\(ParentLN)'" + ", '\(price_level)'" + ", '\(discountvalue)'" + ", '\(12345)'" + ",'\(getTodayString())')"
        
        
        print(strInsertQuery)
        
        Database().insert(query: strInsertQuery, success: {
            print("Successful inserted")
        }) { (error: String) in
            print("Error: \(error)")
        }
        
        let arrData = Database().getData(query: "SELECT FILE_ID FROM SAVE_DATA_MASTER ORDER BY FILE_ID DESC LIMIT 1") { (error: String) in
            print("Error: \(error)")
        }
        if arrData.count > 0 {
            if let file_id = arrData[0]["FILE_ID"] as? Int{
                fileID = file_id
                insertSAVE_PRODUCTToDB(fileID: file_id, product_id: productDictionary.productID, pn: productDictionary.PN)
                
                for item in selectedproductOptions{
                    insertSAVE_OPTIONSToDB(fileID: file_id, product_id: productDictionary.productID, pn: productDictionary.PN, opt_id: item.opt_id, OD: item.OD)
                }
            }
        }
    }
    func insertSAVE_PRODUCTToDB(fileID: Int, product_id: Int, pn: String)  {
        
        var strInsertQuery = String()
        strInsertQuery = "INSERT INTO SAVE_PRODUCT (FILE_ID, PRODUCT_ID, PN, CREATED_DATE_TIME) VALUES (" + "'\(fileID)'" + ", '\(product_id)'" + ", '\(pn)'"  + ",'\(getTodayString())')"
        
        
        print(strInsertQuery)
        
        Database().insert(query: strInsertQuery, success: {
            print("Successful inserted")
        }) { (error: String) in
            print("Error: \(error)")
        }
        
    }
    func insertSAVE_OPTIONSToDB(fileID: Int, product_id: Int, pn: String, opt_id:Int, OD: String)  {
        
        var strInsertQuery = String()
        strInsertQuery = "INSERT INTO SAVE_OPTIONS (FILE_ID, PRODUCT_ID, PN,OPT_ID, OD, CREATED_DATE_TIME) VALUES (" + "'\(fileID)'" + ", '\(product_id)'" + ", '\(pn)'" + ", '\(opt_id)'"  + ", '\(OD)'" + ",'\(getTodayString())')"
        
        
        print(strInsertQuery)
        
        Database().insert(query: strInsertQuery, success: {
            print("Successful inserted")
        }) { (error: String) in
            print("Error: \(error)")
        }
    }
    
    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    
    
    //Update Query
    
    // MARK:-  updateData in canvasTable
    func updateDataInDB(aDictValue:[String : AnyObject],tableName:String,tableKey:String,tableValue:String)  {
        
        var strUpdateQuery = String()
        strUpdateQuery = "UPDATE " + tableName + " " + "SET "
        
        for (key, _) in aDictValue {
            
            if !("\(key)" == tableKey){
                strUpdateQuery = strUpdateQuery + "\(key)='\(aDictValue["\(key)"]!)'" + ","
            }
        }
        
        let endIndex = strUpdateQuery.index(strUpdateQuery.endIndex, offsetBy: -1)
        let truncated = strUpdateQuery.substring(to: endIndex)
        
        strUpdateQuery = truncated + " WHERE \(tableKey)='\(tableValue)'"
        // print(strUpdateQuery)
        
        Database().update(query:strUpdateQuery , success: {
            print("Successful Update")
        }) { (error: String) in
            print("Error: \(error)")
        }
    }
    
    
    func fetchCategory(categoryMasterId:Int) -> [[String:AnyObject]] {
        
        //let getData = "select * from category_master where categoryMasterId = '2' or linkedCatIds like '%2%'"
        
        // let getData = "select * from category_master where categoryMasterId = '\(categoryMasterId)' or linkedCatIds like '%\(categoryMasterId)%'"
        //JP
        //        let getData = "select * from category_master where categoryMasterId = '\(categoryMasterId)'  or linkedCatIds like '\(categoryMasterId),%' or linkedCatIds = '\(categoryMasterId)' or linkedCatIds like '%,\(categoryMasterId),%'  or linkedCatIds like '%,\(categoryMasterId)' "
        
        let getData = "select * from category_master where linkedCatIds like '\(categoryMasterId),%' or linkedCatIds = '\(categoryMasterId)' or linkedCatIds like '%,\(categoryMasterId),%'  or linkedCatIds like '%,\(categoryMasterId)' "
        
        let arrGetData = Database().getData(query: getData) { (error) in
            
            print(error)
        }
        // print(arrGetData)
        return arrGetData as [[String:AnyObject]]
    }
    
    func createTableinDatabase(){
        createDataMasterTable()
        createSaveProductTable()
        createSaveOptionTable()
        
        createDataMaster_TTable()
        createSaveProduct_TTable()
        createSaveOption_TTable()
    }
    
    func createDataMasterTable() {
        
        let getData = "CREATE TABLE IF NOT EXISTS SAVE_DATA_MASTER (FILE_ID INTEGER PRIMARY KEY AUTOINCREMENT, FILE_NAME TEXT NOT NULL, PARENT_LINE_NUMBER TEXT NOT NULL,PRICE_LEVEL  TEXT NOT NULL,DISCOUNT_VALUE TEXT NOT NULL,USER_ID TEXT NOT NULL,CREATED_DATE_TIME  TEXT NOT NULL)"
        
        let _ = Database().createTable(query: getData, success: {
            print("sucess")
        }
        ) { (error) in
            
            print(error)
        }
        // print(arrGetData)
    }
    
    func createSaveProductTable() {
        
        let getData = "CREATE TABLE IF NOT EXISTS SAVE_PRODUCT (FILE_ID INTEGER,PRODUCT_ID  TEXT NOT NULL,PN TEXT NOT NULL,CREATED_DATE_TIME  TEXT NOT NULL)"
        
        
        let _ = Database().createTable(query: getData, success: {
            print("sucess")
        }
        ) { (error) in
            
            print(error)
        }
        // print(arrGetData)
    }
    
    func createSaveOptionTable() {
        
        let getData = "CREATE TABLE IF NOT EXISTS SAVE_OPTIONS (FILE_ID INTEGER,PRODUCT_ID  TEXT NOT NULL,PN  TEXT NOT NULL,OPT_ID  TEXT NOT NULL,OD  TEXT NOT NULL,CREATED_DATE_TIME TEXT NOT NULL)"
        
        
        let _ = Database().createTable(query: getData, success: {
            print("sucess")
        }
        ) { (error) in
            
            print(error)
        }
        // print(arrGetData)
    }
    
    func createDataMaster_TTable() {
        
        let getData = "CREATE TABLE IF NOT EXISTS SAVE_DATA_MASTER_T (WORKSHEET_ID INTEGER PRIMARY KEY AUTOINCREMENT, WORKSHEET_NAME TEXT NOT NULL, PARENT_LINE_NUMBER TEXT NOT NULL,PRICE_LEVEL  TEXT NOT NULL,DISCOUNT_VALUE TEXT NOT NULL,USER_ID TEXT NOT NULL, SORT_BY TEXT NOT NULL, SORT_ORDER_TYPE INTEGER,CREATED_DATE_TIME  TEXT NOT NULL)"
        
        let _ = Database().createTable(query: getData, success: {
            print("sucess")
        }
        ) { (error) in
            
            print(error)
        }
        // print(arrGetData)
    }
    
    func createSaveProduct_TTable() {
        
        let getData = "CREATE TABLE IF NOT EXISTS SAVE_PRODUCT_T (WORKSHEET_ID INTEGER, LINE_NUMBER_ID INTEGER, QUANTITY  INTEGER,PRODUCT_ID  TEXT NOT NULL,PN TEXT NOT NULL,CREATED_DATE_TIME  TEXT NOT NULL)"
        
        
        let _ = Database().createTable(query: getData, success: {
            print("sucess")
        }
        ) { (error) in
            
            print(error)
        }
        // print(arrGetData)
    }
    
    func createSaveOption_TTable() {
        
        let getData = "CREATE TABLE IF NOT EXISTS SAVE_OPTIONS_T (WORKSHEET_ID INTEGER,PRODUCT_ID  TEXT NOT NULL,PN  TEXT NOT NULL,OPT_ID  TEXT NOT NULL,OD  TEXT NOT NULL,CREATED_DATE_TIME TEXT NOT NULL)"
        
        
        let _ = Database().createTable(query: getData, success: {
            print("sucess")
        }
        ) { (error) in
            
            print(error)
        }
        // print(arrGetData)
    }
    
    
    func insertSAVE_DATA_MASTER_TToDB(worksheetName: String, ParentLN: String, price_level: String, discountvalue:String, sortBy:String, sortOrderType:String)  {
        
        
        var strInsertQuery = String()
        strInsertQuery = "INSERT INTO SAVE_DATA_MASTER_T (WORKSHEET_NAME, PARENT_LINE_NUMBER, PRICE_LEVEL, DISCOUNT_VALUE, USER_ID, SORT_BY, SORT_ORDER_TYPE, CREATED_DATE_TIME) VALUES (" + "'\(worksheetName)'" + ", '\(ParentLN)'" + ", '\(price_level)'" + ", '\(discountvalue)'" + ", '\(12345)'" + ",'\(sortBy)'" + ",'\(sortOrderType)'" + ",'\(getTodayString())')"
        
        
        print(strInsertQuery)
        
        Database().insert(query: strInsertQuery, success: {
            print("Successful inserted")
        }) { (error: String) in
            print("Error: \(error)")
        }
        
        let arrData = Database().getData(query: "SELECT WORKSHEET_ID FROM SAVE_DATA_MASTER_T ORDER BY WORKSHEET_ID DESC LIMIT 1") { (error: String) in
            print("Error: \(error)")
        }
        print("worksheetID",arrData.count)
        if arrData.count > 0 {
            if let file_id = arrData[0]["WORKSHEET_ID"] as? Int{
                worksheetID = file_id
            }
        }
    }
    func updateSAVE_DATA_MASTER_TToDB(worksheetName: String, ParentLN: String, price_level: String, discountvalue:String, sortBy:String, sortOrderType:String)  {
        
        
        var strInsertQuery = String()
        strInsertQuery = "update SAVE_DATA_MASTER_T set WORKSHEET_NAME =" + "'\(worksheetName)'" + ",PRICE_LEVEL = '\(price_level)'" + ",DISCOUNT_VALUE = '\(discountvalue)'" + ", SORT_BY = '\(sortBy)'" + ", SORT_ORDER_TYPE = '\(sortOrderType)' where WORKSHEET_ID = '\(worksheetID)'"
        
        
        print(strInsertQuery)
        Database().update(query: strInsertQuery, success: {
            print("Successful updated")
            
        }) { (error: String) in
            print("Error: \(error)")
        }
        
        
        
    }
    func insertSAVE_PRODUCT_TToDB( product_id: Int, pn: String, lineNumberId:Int, quantity : Int)  {
        
        var strInsertQuery = String()
        let arrData = Database().getData(query: "SELECT * FROM SAVE_PRODUCT_T where WORKSHEET_ID = '\(worksheetID)' and PN = '\(pn)'") { (error: String) in
            print("Error: \(error)")
        }
        
        if arrData.count > 0{
            Database().delete(query: "delete from SAVE_PRODUCT_T where WORKSHEET_ID = '\(worksheetID)' and PN = '\(pn)'", success: {
                            print("Successful deleted")

            }) { (error: String) in
                print("Error: \(error)")
            }
        }
        print("worksheetID",arrData.count)
        strInsertQuery = "INSERT INTO SAVE_PRODUCT_T (WORKSHEET_ID, LINE_NUMBER_ID, QUANTITY, PRODUCT_ID, PN, CREATED_DATE_TIME) VALUES (" + "'\(worksheetID)'" + ",'\(lineNumberId)'" + ",'\(quantity)'" + ", '\(product_id)'" + ", '\(pn)'"  + ",'\(getTodayString())')"
        
        
        print(strInsertQuery)
        
        Database().insert(query: strInsertQuery, success: {
            print("Successful inserted")
        }) { (error: String) in
            print("Error: \(error)")
        }
        
    }
    func insertSAVE_OPTIONS_TToDB(fileID: Int, product_id: Int, pn: String, opt_id:Int, OD: String)  {
        
        var strInsertQuery = String()
        strInsertQuery = "INSERT INTO SAVE_OPTIONS_T (WORKSHEET_ID, PRODUCT_ID, PN,OPT_ID, OD, CREATED_DATE_TIME) VALUES (" + "'\(fileID)'" + ", '\(product_id)'" + ", '\(pn)'" + ", '\(opt_id)'"  + ", '\(OD)'" + ",'\(getTodayString())')"
        
        
        print(strInsertQuery)
        
        Database().insert(query: strInsertQuery, success: {
            print("Successful inserted")
        }) { (error: String) in
            print("Error: \(error)")
        }
    }
    
    
}


