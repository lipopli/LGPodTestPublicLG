//
//  TestView.swift
//  TestSwiftRotate
//
//  Created by 李功骄 on 2021/5/21.
//

import UIKit

class TestView: UIView {
    
    var callBack : (()->())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showWith(callBack:(()->())?) {
        self.show()
        
        print("showWith")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.removeFromSuperview()
        }
    }
    
    
    
    func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.addSubview(self)
    }
    
    
    deinit {
        print("TestView 释放了")
    }

}
