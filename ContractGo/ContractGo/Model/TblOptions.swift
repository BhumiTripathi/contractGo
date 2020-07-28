
//
//  ProductDetails.swift
//  ContractGo
//
//  Created by Bhoomika on 24/06/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import Foundation

class TblOptions{
    
    var optID : Int = 0
    var catalog : String = "496"
    var PO : String = "DP8VMMRRWH15"
    var POLA : String = "HTOPCAP"
    var POLR : String = "477"
    var OG : String = "HKNOCKC"
    var ON : String = "KDH"
    var OD : String = "470"
    var O1 : String = ""
    var O2 : String = "HRACEWAY"
    var O3 : String = "452"
    var O4 : String = "MMRRWH15"
    var O5 : String = ""
    var O6 : String = "443"
    var SO : String = "W10778"
    var WU : String = "KDH"
    var VU : String = ""
    var DLA3 : String = "Preconfigured Panel, Full View, Monolithic Monolithic, Fabric to Raceway Side 1 & 2, Worksurface Heightx15W"
    var DLR3 : String = "AFUPA-3D-TL-FA-H"
    var IM : String = "367"
    var MGT :  String = "KDH"
    var MGV :  String = ""
    
    
    init(){
        
    }
    
    init(json:[String:Any]) {
        self.optID   = json["optID"] as? Int ?? 0
        self.catalog   = json["catalog"] as? String ?? ""
        self.PO   = json["PO"] as? String ?? ""
        self.POLA   = json["POLA"] as? String ?? ""
        self.POLR   = json["POLR"] as? String ?? ""
        self.OG   = json["OG"] as? String ?? ""
        self.ON   = json["ON"] as? String ?? ""
        self.OD   = json["OD"] as? String ?? ""
        self.O1   = json["O1"] as? String ?? ""
        self.O2   = json["O2"] as? String ?? ""
        self.O3   = json["O3"] as? String ?? ""
        self.O4   = json["O4"] as? String ?? ""
        self.O5   = json["O5"] as? String ?? ""
        self.O6   =  json["O6"] as? String ?? ""
        self.SO   =  json["SO"] as? String ?? ""
        self.VU   = json["VU"] as? String ?? ""
        self.DLA3   =  json["3DLA"] as? String ?? ""
        self.DLR3   =  json["3DLR"] as? String ?? ""
        self.IM   =  json["IM"] as? String ?? ""
        self.MGT   =  json["MGT"] as? String ?? ""
        self.MGV   = json["MGV"] as? String ?? ""
        
        print(OG, OD, O1)
    }
    
}
