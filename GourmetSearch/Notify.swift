//
//  NSNotification.swift
//  GourmetSearch
//
//  Created by ShinichiHirauchi on 2015/06/21.
//  Copyright (c) 2015年 SAPPOROWORKS. All rights reserved.
//

import Foundation

public class Notify{

    private var localDataObserver:NSObjectProtocol?
    private var name = ""

    init(name:String,handler:(NSNotification!)->Void){
        self.name = name
        localDataObserver = NSNotificationCenter.defaultCenter().addObserverForName(name, object: nil, queue:nil, usingBlock:handler);
    }
    
    deinit{
        //オブザーバーの破棄
        NSNotificationCenter.defaultCenter().removeObserver(localDataObserver!)
    }
    
    func post(userInfo: [NSObject : AnyObject]? = nil){
        NSNotificationCenter.defaultCenter().postNotificationName(name,object: nil,userInfo: userInfo)
    }
    
    
    
    //static func post(aName: String, userInfo: [NSObject : AnyObject]? = nil){
    //    NSNotificationCenter.defaultCenter().postNotificationName(aName,object: nil,userInfo: userInfo)
    //}
    
    //static func addObserver(name:String?,usingBlock:(NSNotification!)->Void)-> NSObjectProtocol{
    //    return NSNotificationCenter.defaultCenter().addObserverForName(name, object: nil, queue:nil, usingBlock:usingBlock);
    //}

}