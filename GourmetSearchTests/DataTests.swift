//
//  DataTests.swift
//  GourmetSearch
//
//  Created by ShinichiHirauchi on 2015/06/21.
//  Copyright (c) 2015年 SAPPOROWORKS. All rights reserved.
//

import UIKit
import XCTest

class DataTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    func testXとYを足すメソッド(){
        var params = [  (1,2,3),
                        (2,3,5),
                        (2,2,4)]
        
        for (x,y,expected) in params {
            
            //setUp
            let sut = Data()
            //let expected = e
            
            //exercise
            let actual = sut.Add(x,y:y)
            
            //verify
            XCTAssertEqual(actual, expected)
            
            //tearDown
            
        }
    }
    
    
    func testExample() {
        var isExists = false
        var sut = Data()
        let result = sut.Add(1,y:2)
        XCTAssert(result == 3, "Pass")
    }

    func testPerformanceExample() {
        self.measureBlock() {

        }
    }
    
    

}
