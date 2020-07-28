//
//  ProductDetails.swift
//  ContractGo
//
//  Created by Bhoomika on 24/06/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import Foundation

class ProductDetails{
    
    var PNIM : String = ""
    var P1 : String = "496"
    var PN : String = "DP8VMMRRWH15"
    var G0 : String = "HTOPCAP"
    var P2 : String = "477"
    var G1 : String = "HKNOCKC"
    var catalog : String = "KDH"
    var P3 : String = "470"
    var WT : String = ""
    var G2 : String = "HRACEWAY"
    var P4 : String = "452"
    var G3 : String = "MMRRWH15"
    var NT : String = ""
    var P5 : String = "443"
    var IM : String = "W10778"
    var PC : String = "KDH"
    var G4 : String = ""
    var PD : String = "Preconfigured Panel, Full View, Monolithic Monolithic, Fabric to Raceway Side 1 & 2, Worksurface Heightx15W"
    var DLA3 : String = "AFUPA-3D-TL-FA-H"
    var P6 : String = "367"
    var GC :  String = "KDH"
    var G5 :  String = ""
    var DLR3 : String = ""
    var DH : String = "0"
    var PT : String = ""
    var D3 :  String = "TPMMRRWZ"
    var NI :  String = ""
    var G6 :  String = ""
    var EV :  String = "  ----"
    var G7 :  String = ""
    var PV :  String = "PPWZ"
    var G8 :  String = ""
    var G9 :  String = ""
    var VO :  String = ""
    var productID :  Int = 31040
    var NO : String = ""
    var TG : String = "WH 15"
    
    init(){
        
    }
    
    init(json:[String:Any]) {
        self.PNIM   = json["PNIM"] as? String ?? ""
        self.P1   = json["P1"] as? String ?? ""
        self.PN   = json["PN"] as? String ?? ""
        self.G0   = json["G0"] as? String ?? ""
        self.P2   = json["P2"] as? String ?? ""
        self.G1   = json["G1"] as? String ?? ""
        self.catalog   = json["catalog"] as? String ?? ""
        self.P3   = json["P3"] as? String ?? ""
        self.WT   = json["WT"] as? String ?? ""
        self.G2   = json["G2"] as? String ?? ""
        self.P4   = json["P4"] as? String ?? ""
        self.G3   = json["G3"] as? String ?? ""
        self.NT   = json["NT"] as? String ?? ""
        self.P5   =  json["P5"] as? String ?? ""
        self.IM   =  json["IM"] as? String ?? ""
        self.PC   =  json["PC"] as? String ?? ""
        self.G4   = json["G4"] as? String ?? ""
        self.PD   =  json["PD"] as? String ?? ""
        self.DLA3   =  json["3DLA"] as? String ?? ""
        self.P6   =  json["P6"] as? String ?? ""
        self.GC   =  json["GC"] as? String ?? ""
        self.G5   = json["G5"] as? String ?? ""
        self.DLR3   = json["3DLR"] as? String ?? ""
        self.DH   =  json["DH"] as? String ?? ""
        self.PT   = json["PT"] as? String ?? ""
        self.D3   =  json["D3"] as? String ?? ""
        self.NI   = json["NI"] as? String ?? ""
        self.G6   = json["G6"] as? String ?? ""
        self.EV   = json["EV"] as? String ?? ""
        self.G7   = json["G7"] as? String ?? ""
        self.PV   =  json["PV"] as? String ?? ""
        self.G8   = json["G8"] as? String ?? ""
        self.G9   = json["G9"] as? String ?? ""
        self.VO   = json["VO"] as? String ?? ""
        self.productID = json["productID"] as? Int ?? 0
        self.NO   = json["NO"] as? String ?? ""
        self.TG   =  json["TG"] as? String ?? ""
    }
    
}
