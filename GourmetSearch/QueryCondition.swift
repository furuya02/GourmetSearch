//
//  QueryCondition.swift
//  GourmetSearch
//
//  Created by ShinichiHirauchi on 2015/06/20.
//  Copyright (c) 2015年 SAPPOROWORKS. All rights reserved.
//

import Foundation

public struct QueryCondition{
    // キーワード
    public var query: String? = nil
    // 店舗ID
    public var gid:String? = nil
    // ソート順
    public enum Sort:String{
        case Score = "score"
        case Geo = "geo"
    }
    public var sort:Sort = .Score
    // 軽度
    public var lat:Double?=nil
    // 緯度
    public var lon:Double?=nil
    // 距離
    public var dist:Double?=nil
    
    public var queryParams:[String:String]{
        get{
            var params = [String:String]()
            if let unwrapped = query {
                params["query"] = unwrapped
            }
            if let unwrapped = gid {
                params["gid"] = unwrapped
            }
            switch sort{
            case .Score:
                params["sort"] = "score"
            case .Geo:
                params["sort"] = "geo"
                
            }
            if let unwrapped = lat{
                params["lat"] = "\(unwrapped)"
            }
            if let unwrapped = lon{
                params["lon"] = "\(unwrapped)"
            }
            if let unwrapped = dist{
                params["dist"] = "\(unwrapped)"
            }
            params["device"] = "mobile"
            params["group"] = "gid"
            params["image"] = "true"
            params["gc"] = "01"
            
            return params
        }
    }
    
    
}
