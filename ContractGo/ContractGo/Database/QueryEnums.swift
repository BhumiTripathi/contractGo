//
//  QueryEnums.swift
//  ContractGo
//
//  Created by Bhoomika on 22/06/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import Foundation
import UIKit

class QueryEnum : NSObject {
    
    func FirstLevelFetch() -> [[String:Any]] {
        let arrData = Database().getData(query: "select * from tblTableOfContents WHERE PN='null' AND parentLineNumber='' and tocID<60000 order by lineNumber limit 2") { (error: String) in
            print("Error: \(error)")
        }
        return arrData
    }
    
    func SecondLevelfetch() -> [[String:Any]]{
        let arrData = Database().getData(query: "select * from tblTableOfContents WHERE PN='null' AND parentLineNumber='' and tocID<60000 order by lineNumber limit 2, 5000") { (error: String) in
            print("Error: \(error)")
        }
        
        return arrData
    }
    
    func repetitiveFetch(parentLineNumber : Int) -> [[String:Any]]{
        let str  = "select * from tblTableOfContents WHERE parentLineNumber=" + "\(parentLineNumber)" + " and SL != 'null' " +  " and tocID<60000 order by lineNumber"
        
        let arrData = Database().getData(query: str) { (error: String) in
            print("Error: \(error)")
        }
        
        return arrData
    }
    
    func listFetch(parentLineNumber : Int) -> [[String:Any]]{
        let str  = "select * from tblTableOfContents INNER JOIN tblProduct on tblTableOfContents.PN=tblProduct.PN WHERE tblTableOfContents.PN<>'null' AND tblTableOfContents.parentLineNumber=" + "'\(parentLineNumber)'" + " and tocID<60000 order by lineNumber"
        
        let arrData = Database().getData(query: str) { (error: String) in
            print("Error: \(error)")
        }
        
        return arrData
    }
    
    func productFetch(PN : String) -> [[String:Any]]{
        let str  = "select * from tblProduct where PN="  + "'\(PN)'" + " AND productID<60000"
        
        let arrData = Database().getData(query: str) { (error: String) in
            print("Error: \(error)")
        }
        
        return arrData
    }
    
    func fetchTableOptions(PO : String) -> [[String:Any]]{
        let str  = "select * from tblOptions where PO="  + "'\(PO)'" + " and optID<11000000"
        
        let arrData = Database().getData(query: str) { (error: String) in
            print("Error: \(error)")
        }
        //  print(arrData)
        return arrData
    }
    func fetchWorksheet() -> [[String:Any]]{
        let str  = "select * from SAVE_DATA_MASTER_T"
        
        let arrData = Database().getData(query: str) { (error: String) in
            print("Error: \(error)")
        }
        
        return arrData
    }
    
    func fetchWorksheetProduct(worksheetId: Int) -> [[String:Any]]{
           let str  = "select * from SAVE_PRODUCT_T where WORKSHEET_ID = \(worksheetId)"
           
           let arrData = Database().getData(query: str) { (error: String) in
               print("Error: \(error)")
           }
           
           return arrData
       }
}
