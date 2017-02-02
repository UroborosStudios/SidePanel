//
//  DataTypes.swift
//  sidePanel
//
//  Created by Jonathan  Silva on 01/02/17.
//  Copyright © 2017 Sye. All rights reserved.
//

import Foundation
import UIKit

public enum Panel {
    case left
    case right
    case other
}

public enum PanelStatus {
    case leftExpanded
    case rightExpanded
    case closed
}

extension UIViewController {
    
    open func closePanelsAndDismiss(animated:Bool,completion: (()->Void)?) {
        let container = ContainerViewController.container!
        if container.isPanelExpanded() {
            container.closePanels(complete: {
                self.dismiss(animated: animated, completion: completion)
            })
        } else {
            self.dismiss(animated: animated, completion: completion)
        }
    }
    
    open func configPanelsInNavigationBar(left:String?,right:String?) {
        if left != nil && ContainerViewController.container.leftPanel != nil {
            let leftMenu  = UIBarButtonItem(title: left!, style: .plain, target: self, action: #selector(self.toggleLeft))
            self.navigationItem.leftBarButtonItem  = leftMenu
        }
        
        if right != nil && ContainerViewController.container.rightPanel != nil {
            let rightMenu = UIBarButtonItem(title: right!, style: .plain, target: self, action: #selector(self.toggleRight))
            self.navigationItem.rightBarButtonItem = rightMenu
        }
    }
    
    open func configPanelsInNavigationBarWithIcons(left:UIImage?,right:UIImage?) {
        if left != nil && ContainerViewController.container.leftPanel != nil {
            let leftMenu  = UIBarButtonItem(image: left!, style: .plain, target: self, action: #selector(self.toggleLeft))
            self.navigationItem.leftBarButtonItem  = leftMenu
        }
        
        if right != nil && ContainerViewController.container.rightPanel != nil {
            let rightMenu = UIBarButtonItem(image: right!, style: .plain, target: self, action: #selector(self.toggleRight))
            self.navigationItem.rightBarButtonItem = rightMenu
        }
    }
    
    open func toggleLeft() {
        ContainerViewController.container.togglePanel(panel: .left)
    }
    
    open func toggleRight() {
        ContainerViewController.container.togglePanel(panel: .right)
    }
}

extension UINavigationController {
    
    open func popViewControllerDismissingPanels(animated:Bool) {
        let container = ContainerViewController.container!
        if container.isPanelExpanded() {
            container.closePanels(complete: {
                _ = self.popViewController(animated: true)
            })
        } else {
            _ = self.popViewController(animated: true)
        }
    }
    
    open func popToViewControllerDismissingPanels(viewController:UIViewController,animated:Bool) {
        let container = ContainerViewController.container!
        if container.isPanelExpanded() {
            container.closePanels(complete: {
                _ = self.popToViewController(viewController, animated: animated)
            })
        } else {
            _ = self.popToViewController(viewController, animated: animated)
        }
    }
    
    open func popToRootDismissingPanels(viewController:UIViewController,animated:Bool) {
        let container = ContainerViewController.container!
        if container.isPanelExpanded() {
            container.closePanels(complete: {
                _ = self.popToRootViewController(animated: animated)
            })
        } else {
            _ = self.popToRootViewController(animated: animated)
        }
    }
    
}

extension UIApplication {
    
    
}
