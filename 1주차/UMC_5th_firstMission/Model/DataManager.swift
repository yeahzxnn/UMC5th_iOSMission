//
//  DataManager.swift
//  UMC_5th_firstMission
//
//  Created by 신예진 on 10/4/23.
//


import Foundation
import UIKit

struct ShopItem{
    let image: UIImage?
    let text: String
}
struct StoreItem{
    let foodImageView: UIImage?
    let storeLabel: String
    let scoreLabel: String
    
    let deliveryLabel: String
    let deliveryTextLabel: String
    
    let deliveryTipLabel: String
    let deliveryTipTextLabel: String
    
    let uiImageView: UIImage?
    
    
}
struct MartShoppingItem{
    let foodImageView: UIImage?
    let titleLabel: String
    let saleLabel: String
    let originPriceLabel: String
    let salePriceLabel: String
}

struct MartShoppingSection{
    let headerTitle :String?
    let headerImage :UIImage
    let headerButton:UIImage?
    let items: [MartShoppingItem]
}
struct ShopSection{
    let headerTitle :String?
    let headerImage :UIImage
    let headerButton:UIImage?
    let items: [ShopItem]
}
struct StoreSection{
    let headerTitle :String?
    let headerImage :UIImage
    let headerButton:UIImage?
    let items: [StoreItem]
    
}
class SecondCellDataManager {
    private var secondDataArray: [ShopItem] = []
    func makesecondData(){
        secondDataArray = [
            ShopItem(image: UIImage(named: "주문1")!, text: "알뜰배달"),
            ShopItem(image: UIImage(named: "주문2")!, text: "돈가스.회"),
            ShopItem(image: UIImage(named: "주문3")!, text: "피자"),
            ShopItem(image: UIImage(named: "주문4")!, text: "중식"),
            ShopItem(image: UIImage(named: "주문5")!, text: "치킨"),
            ShopItem(image: UIImage(named: "주문6")!, text: "버거"),
            ShopItem(image: UIImage(named: "주문7")!, text: "분식"),
            ShopItem(image: UIImage(named: "주문8")!, text: "디저트"),
            ShopItem(image: UIImage(named: "주문9")!, text: "족발.보쌈"),
            ShopItem(image: UIImage(named: "주문10")!, text: "전체보기"),
            
        ]
        
    }
    func getSecondCellData() -> [ShopItem] {
        return secondDataArray
    }
}
