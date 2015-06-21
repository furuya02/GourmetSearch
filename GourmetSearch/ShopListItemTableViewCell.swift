//
//  ShopListItemTableViewCell.swift
//  GourmetSearch
//
//  Created by ShinichiHirauchi on 2015/06/20.
//  Copyright (c) 2015年 SAPPOROWORKS. All rights reserved.
//

import UIKit

class ShopListItemTableViewCell: UITableViewCell {

    //MARK: - Outlet
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var iconContainer: UIView!
    @IBOutlet weak var coupon: UILabel!
    @IBOutlet weak var station: UILabel!
    @IBOutlet weak var nameHeight: NSLayoutConstraint!
    @IBOutlet weak var stationWidth: NSLayoutConstraint!
    @IBOutlet weak var stationX: NSLayoutConstraint!
    
    var shop : Shop = Shop(){
        didSet{
            //名前
            name.text = shop.name
            //クーポン
            var x:CGFloat=0
            var margin:CGFloat = 10
            if shop.hasCoupon {
                coupon.hidden = false
                x += coupon.frame.size.width + margin
                coupon.layer.cornerRadius = 4
                coupon.clipsToBounds = true
            }else{
                coupon.hidden = true
            }
            //駅
            if shop.station != nil {
                station.hidden = false
                station.text = shop.station
                //ラベル位置
                stationX.constant = x
                //ラベル幅
                let size = station.sizeThatFits(CGSizeMake(CGFloat.max, CGFloat.max))
                if x + size.width + margin > iconContainer.frame.width{
                    stationWidth.constant = size.width + margin
                }else{
                    stationWidth.constant = size.width + margin
                }
                station.clipsToBounds = true
                station.layer.cornerRadius = 4
            }else{
                station.hidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
