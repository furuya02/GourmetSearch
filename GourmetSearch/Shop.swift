//
//  Shop.swift
//  GourmetSearch
//
//  Created by ShinichiHirauchi on 2015/06/20.
//  Copyright (c) 2015年 SAPPOROWORKS. All rights reserved.
//

import Foundation

public struct Shop : Printable{
    public var gid:String?=nil
    public var name:String?=nil
    public var photoUrl:String?=nil
    public var yomi:String?=nil
    public var tel:String?=nil
    public var address:String?=nil
    public var lat:Double?=nil
    public var lon:Double?=nil
    public var catchCopy:String?=nil
    public var hasCoupon=false
    public var station:String?=nil
    
    public var description : String {
        get{
            var string = "\nGid:\(gid)\n"
            string += "Name: \(name)\n"
            string += "PhotoUrl: \(photoUrl)\n"
            string += "Yomi: \(yomi)\n"
            string += "Tel: \(tel)\n"
            string += "Address: \(address)\n"
            string += "Lat & Lon: (\(lat),\(lon))\n"
            string += "CatchCopy: \(catchCopy)\n"
            string += "hasCoupon: \(hasCoupon)\n"
            string += "Station: \(station)\n"
            return string
        }
    }
}