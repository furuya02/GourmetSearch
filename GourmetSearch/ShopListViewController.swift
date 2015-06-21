//
//  ViewController.swift
//  GourmetSearch
//
//  Created by ShinichiHirauchi on 2015/06/20.
//  Copyright (c) 2015年 SAPPOROWORKS. All rights reserved.
//

import UIKit

class ShopListViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var yls = YahooLocalSearch(httpClient: HttpClient())
    //var localDataObserver:NSObjectProtocol?
    
    var notify : Notify?

    @IBAction func buttonTapped(sender: AnyObject) {
        search()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func reload(n: NSNotification!) -> Void {
        self.tableView.reloadData()
        if n.userInfo != nil {
            if let userInfo = n.userInfo as? [String:String!]{
                if userInfo["error"] != nil {
                    self.alert("通信エラー",message: "通信エラーが発生しました")
                }
                
            }
            
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        notify = Notify(name:"NAME",handler:{
            (n) in
            self.reload(n)
        })
        
        //読み込み完了時の処理
        //localDataObserver = Notify.addObserver(yls.YLSLoadCompleteNotification,
        //    usingBlock: {(n) in self.reload(n) }
        //)
        
        
        
        /*
        localDataObserver = Notify.addObserver(yls.YLSLoadCompleteNotification,
            usingBlock:{
                (n) in
                self.tableView.reloadData()
                if n.userInfo != nil {
                    if let userInfo = n.userInfo as? [String:String!]{
                        if userInfo["error"] != nil {
                            self.alert("通信エラー",message: "通信エラーが発生しました")
                        }
                        
                    }
                    
                }
            }
        )
        */
        /*
        localDataObserver = NSNotificationCenter.defaultCenter().addObserverForName(yls.YLSLoadCompleteNotification, object: nil, queue: nil,
            usingBlock: {
                (n) in
                
                self.tableView.reloadData()

                if n.userInfo != nil {
                    if let userInfo = n.userInfo as? [String:String!]{
                        if userInfo["error"] != nil {
                            self.alert("通信エラー",message: "通信エラーが発生しました")
                        }
                        
                    }
                    
                }
            }
        )
        */
        //検索
        search()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        notify = nil // 画面遷移で破棄する
        //NSNotificationCenter.defaultCenter().removeObserver(self.localDataObserver!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Alert
    func alert(title: String,message: String){
        let alertView = UIAlertController(title: title, message: message,preferredStyle: .Alert)
        
        alertView.addAction(
            UIAlertAction(title: "OK", style: .Default){
                action in return
            }
        )
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    //MARK: - Search
    func search(){
        var qc = QueryCondition()
        qc.query = "フレンチ"
        yls.loadData(notify,condition: qc,reset: true)
    }
    
    //MARK: - TableView
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row < yls.shops.count{
                let cell = tableView.dequeueReusableCellWithIdentifier("ShopListItem") as! ShopListItemTableViewCell
                cell.shop = yls.shops[indexPath.row]
                return cell
            }
//            let cell = tableView.dequeueReusableCellWithIdentifier("ShopListItem") as! ShopListItemTableViewCell
//            cell.name.text = "\(indexPath.row)"
//            return cell
        }
        return UITableViewCell()
    }
    
}

