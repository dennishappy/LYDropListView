//
//  ViewController.swift
//  LYDropListView
//
//  Created by discover on 2017/9/28.
//  Copyright © 2017年 LY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let moneyArray:[String] = ["不限金额","0~1000元","1001~2000元","2001~3000元","3001~5000元","5000元以上"]
    let limitArray:[String] = ["不限期限","0~14天","15~30天","30~60天","60~90天","90~180天","180~360天","360天以上"]
    let sortArray:[String] = ["默认排序","贷款成功率 ↓","日费率 ↑"]
  
    
    lazy var dropList:LYDropListView = {
        //传入一个二维数组即可
        let drop = LYDropListView.init(frame: CGRect.init(x: 0, y: kNaviHeight, width: screenWidth, height: 40), tableArr: [self.moneyArray,self.limitArray,self.sortArray], selectClosure: { (tag, row) in
            //tag - 100是第几个标题菜单，row是菜单第几行
              print(tag-100,row)
        })
        return drop
    }()
    
    
    lazy var dropView:LYDropView = {
        //传入一个二维数组即可
        let drop = LYDropView.init(frame: CGRect.init(x: 0, y: kNaviHeight * 2 + 30, width: screenWidth, height: 40), selectClosure: { (tag, row) in
            //tag - 100是第几个标题菜单，row是菜单第几行
              print(tag-100,row)
        })
        drop.backgroundColor = UIColor.orange
        return drop
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dropList)
        
        view.addSubview(dropView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

