//
//  SideViewController.swift
//  sidePanel
//
//  Created by Jonathan  Silva on 01/02/17.
//  Copyright © 2017 Sye. All rights reserved.
//

import UIKit

open class SideViewController: UIViewController {

    var notifyWillShow : ((_ args:[String:AnyObject]) -> Void)? = nil
    var notifyDidShow : ((_ args:[String:AnyObject]) -> Void)? = nil
    var notifyWillHide : ((_ args:[String:AnyObject]) -> Void)? = nil
    var notifyDidHide : ((_ args:[String:AnyObject]) -> Void)? = nil
}

extension SideViewController : SidePanelDelegate {
    
    public func panelWillShow() {
        print("Panel Will Show")
    }
    
    public func panelDidShow() {
        print("Panel Did Show")
    }
    
    public func panelWillHide() {
        print("Panel Will Hide")
    }
    
    public func panelDidHide() {
        print("Panel Did Hide")
    }
}
