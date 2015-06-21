//
//  YahooSearch.swift
//  GourmetSearch
//
//  Created by ShinichiHirauchi on 2015/06/20.
//  Copyright (c) 2015年 SAPPOROWORKS. All rights reserved.
//

import Foundation
import SwiftyJSON

public class YahooLocalSearch{
    private var httpClient = HttpClient()
    
    
    let apiId = SecretKey.appId // アプリケーションID(Githubでは配布されていません)
    let apiUrl = "http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch"
    let testKey = SecretKey.testKey

    //通知メッセージ
    let YLSLoadStartNotification = "YLSLoadStartNotification"
    let YLSLoadCompleteNotification = "YLSLoadCompleteNotification"
    
    // １ページのレコード数
    let perPage = 10
    
    // 読み込み済み店舗
    public var shops = [Shop]()
    
    public var total  = 0

    public init(httpClient: HttpClient){
        self.httpClient = httpClient
    }
 
    func readOneShop(key: String,item: JSON) -> Shop {
        var shop = Shop()
        
        shop.gid = item["Gid"].string
        shop.name = item["Name"].string
        //Nameのエンコード
        
        let p = item["Property"]
        if p != nil {
            shop.yomi = p["Yomi"].string
            shop.tel = p["Tell"].string
            shop.address = p["Address"].string
            
            //経度緯度
            
            
            shop.catchCopy = p["CatchCopy"].string
            shop.photoUrl = p["LoadImage"].string
            if p["CouponFlag"].string == "true" {
                shop.hasCoupon = true
            }
            if let stations = p["Station"].array{
                var line = ""
                if let lineString = stations[0]["Railway"].string{
                    let lines = lineString.componentsSeparatedByString("/")
                    line = lines[0]
                }
                if let station = stations[0]["Name"].string {
                    shop.station = "\(line) \(station)"
                }else{
                    shop.station = "\(line)"
                }
            }
            
        }
        return shop
    }

    func read(json:JSON)->[Shop]{
        
        var ar = [Shop]()
        
        for (k,i) in json["Feature"]{
            var shop = readOneShop(k,item:i)
            ar.append(shop)
        }
        return ar
    }
    
    // APIからデータを読み込む
    //reset = true データを捨ててから読み込む
    public func loadData(notify: Notify?,condition: QueryCondition,reset:Bool = false){
        
        //通知（検査開始）
        //if let n = notify {
        //    n.post()
        //}
        
        //reset=trueの時、既存のデータを初期化する
        if reset {
            shops = []
            total = 0
        }
        var params = condition.queryParams
        params["appid"] = apiId
        params["output"] = "json"
        params["start"] = String(shops.count+1)
        params["results"] = String(perPage)
        
        var hc = HttpClient()
        var req = hc.request(.GET, URLString: apiUrl, parameters: params)
        hc.response(req,completionHandler:{ (request, response, data, error) -> Void in
            var json = hc.serializer(data,error: error)
            
            if error != nil {
                var message = "Unknown error."
                
                if let description = error?.description {
                    message = description
                }
                //通知（エラー）
                if let n = notify { n.post(userInfo: ["error":message]) }
                return
            }
            
            self.shops = self.read(json)

            if let total = json["ResultInfo"]["Total"].int {
                self.total = total
            }else{
                self.total = 0
            }
            //通知(完了)
            if let n = notify { n.post() }
        })
    }
}

