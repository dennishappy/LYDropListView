//
//  LYDropView.swift
//  LYDropListView
//
//  Created by 朴社长 on 2021/3/15.
//  Copyright © 2021 LY. All rights reserved.
//

import UIKit

class LYDropView: UIView {

    var maskViewSS:UIView?
    
    
    lazy var titleView:LYDropListTItleView = {
        let view = LYDropListTItleView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 40), title: "Click Me")
        return view
    }()
    
    lazy var filterView:LYFilterView = {
        let filterView:LYFilterView = Bundle.main.loadNibNamed("LYFilterView", owner: self, options: nil)?.last as! LYFilterView
        filterView.isHidden = true
        filterView.frame = CGRect(x: 0, y: 40, width: screenWidth, height: 0)
        return filterView
    }()
    var selectClosure:((_ tag:Int,_ row:Int)->Void)?
    init(frame: CGRect,selectClosure : @escaping (_ tag:Int,_ row:Int)->Void) {
        super.init(frame: frame)
        self.selectClosure = selectClosure
        self.backgroundColor = UIColor.white
        self.setTitleButton()
        setMaskView()
        
        setFilterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setMaskView(){
        maskViewSS = UIView.init(frame: CGRect.init(x: 0, y: 40, width: screenWidth, height: screenHeight-40-kNaviHeight))
        maskViewSS?.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.3)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        maskViewSS?.alpha = 0
        maskViewSS?.addGestureRecognizer(tap)
        
    }
    
    func setFilterView(){
        addSubview(filterView)
    }
    
    @objc func tapAction(){
        self.maskViewSS?.removeFromSuperview()
        if filterView.frame.height>1{
            titleView.isSelected = false
            UIView.animate(withDuration: 0.2, animations: {
                
                self.filterView.isHidden = true
                self.filterView.frame = CGRect(x: 0, y: 40, width: screenWidth, height: 1)
                self.maskViewSS?.alpha = 0
            }, completion: { (idCom) in
                self.maskViewSS?.removeFromSuperview()
            })
        }
    }
    func setTitleButton(){
        titleView.gesClosure = { [weak self](select)->Void in
            self?.insertSubview(self?.maskViewSS ?? UIView(), at: 0)
            UIView.animate(withDuration: 0.2, animations: {
                self?.maskViewSS?.alpha = 1
            })
            if select {
                self?.filterView.isHidden = false
                self?.filterView.frame = CGRect(x: 0, y: 40, width: screenWidth, height: 300)
            }else{
                UIView.animate(withDuration: 0.2, animations: {
                    self?.filterView.isHidden = true
                    self?.filterView.frame = CGRect(x: 0, y: 40, width: screenWidth, height: 1)
                    self?.maskViewSS?.alpha = 0
                }, completion: { (idCom) in
                    self?.maskViewSS?.removeFromSuperview()
                })
            }
        }
        self.addSubview(titleView)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)
        if view == nil {
            for subView in self.subviews {
                let tp = subView.convert(point, from: self)
                if subView.bounds.contains(tp) {
                    view = subView
                }
            }
        }
        return view
    }
}
