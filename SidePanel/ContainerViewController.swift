//
//  ContainerViewController.swift
//  sidePanel
//
//  Created by Jonathan  Silva on 01/02/17.
//  Copyright © 2017 Sye. All rights reserved.
//

import UIKit

public class ContainerViewController: UIViewController {

    public enum NavigationType {
        case Navigation
        case Tab
        case MasterDetail
    }
    
    // MARK: - Data types
    public var currentVC : UIViewController? = nil
    public var navigationType : NavigationType = .Navigation
    var panelState : PanelStatus = .closed {
        didSet {
            let shouldShadow = panelState != .closed
            showShadowForCenterViewController(shouldShadow)
        }
    }
    
    let centerPanelExpandedOffset : CGFloat = 60
    
    var closeNotification : (()->Void)? = nil
    
    // MARK: - Side Panels Variables
    
    public var rootVC    : UIViewController!
    public var leftPanel : SideViewController? = nil
    public var rightPanel : SideViewController? = nil
    
    public static var container : ContainerViewController!
    
    // MARK: - Bases
    public var centerController : UIViewController!
    var navController: UINavigationController? = nil
    var tabController: UITabBarController? = nil
    
    
    
    public init(window: inout UIWindow, rootView:UIViewController, navigationType nType: NavigationType, leftPanel: inout SideViewController?, rightPanel: inout SideViewController?) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationType = nType
        self.rootVC = rootView
        
        window.rootViewController = self
        window.makeKeyAndVisible()
        
        if leftPanel == nil && rightPanel == nil {
            print("You cant create a container without providing a left or right panel")
            return;
        }
        
        if let left = leftPanel {
            left.view.frame.size.width -= centerPanelExpandedOffset
        }
        if let right = rightPanel {
            right.view.frame.size.width -= centerPanelExpandedOffset
            right.view.frame.origin.x = centerPanelExpandedOffset
        }
        
        self.leftPanel = leftPanel
        self.rightPanel = rightPanel
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        ContainerViewController.container = self
        
        if navigationType == .Navigation {
            navController = UINavigationController(rootViewController: rootVC)
            navController!.delegate = self
            centerController = navController!
        } else if navigationType == .Tab {
            tabController = UITabBarController()
            centerController = tabController!
        }
        
        self.view.addSubview(centerController.view)
        self.addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
    }

}

extension ContainerViewController : MainVCDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    public func togglePanel(panel: Panel) {
        var expanded = false
        let panelView = (panel == .left ? leftPanel! : rightPanel!)
        
        if panel == .right && panelState == .rightExpanded {
            panelState = .closed
            expanded = true
        } else if panel == .left && panelState == .leftExpanded {
            panelState = .closed
            expanded = true
        }
        
        // If the other panel is open, close it first and then open the correct one
        if (panel == .right && panelState == .leftExpanded) || (panel == .left && panelState == .rightExpanded) {
            closePanels(complete: { 
                self.togglePanel(panel: panel)
            })
        } else {
            // Normal behaviour
            if !expanded {
                panelState = (panel == .left ? .leftExpanded : .rightExpanded)
                addSidePanelToCurrent(panel: panelView)
            }
            animatePanel(panelView: panelView, shouldExpand: !expanded)
        }
    }
    
    public func isPanelExpanded() -> Bool {
        if panelState != .closed {
            return true
        }
        return false
    }
    
    public func closePanels(complete: @escaping () -> Void) {
        closeNotification = complete
        if panelState == .leftExpanded {
            togglePanel(panel: .left)
        } else {
            togglePanel(panel: .right)
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        currentVC = viewController
    }
    
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //
        currentVC = viewController
    }
    
}

extension ContainerViewController {
    
    func addSidePanelToCurrent(panel:SideViewController) {
        // We access centerController because we need to add it to the navigation or tab controller instead of the currentVC
        
        // Functional (Side Panels have no interaction)
        //centerController.view.insertSubview(panel.view, at: 0)
        //centerController.addChildViewController(panel)
        //panel.didMove(toParentViewController: centerController)
        
        currentVC!.view.superview?.insertSubview(panel.view, at: 0)
        currentVC!.parent?.addChildViewController(panel)
        panel.didMove(toParentViewController: self)
    }
    
    func removePanel(_ panel:SideViewController) {
        panel.view.removeFromSuperview()
        panel.removeFromParentViewController()
    }
    
    func animatePanel(panelView: SideViewController, shouldExpand: Bool) {
        //
        self.view.isUserInteractionEnabled = false
        if shouldExpand {
            panelView.panelWillShow()
            var xPosition = currentVC!.view.frame.width - centerPanelExpandedOffset
            if panelState == .rightExpanded { xPosition = -xPosition }
            animateCenterPanelXPosition(targetPosition: xPosition, completion: { (finished) in
                self.showDidFinish(panel: panelView)
            })
        } else {
            panelView.panelWillHide()
            animateCenterPanelXPosition(targetPosition: 0, completion: { (finished) in
                self.hideDidFinish(panel: panelView)
            })
        }
    }
    
    func showDidFinish(panel:SideViewController) {
        panel.panelDidShow()
        self.view.isUserInteractionEnabled = true
        if let finishAction = self.closeNotification {
            finishAction()
            self.closeNotification = nil
        }
    }
    
    func hideDidFinish(panel:SideViewController) {
        panel.panelDidHide()
        self.view.isUserInteractionEnabled = true
        self.removePanel(panel)
        if let finishAction = self.closeNotification {
            finishAction()
            self.closeNotification = nil
        }
    }
    
    func animateCenterPanelXPosition(targetPosition x: CGFloat, completion: @escaping ((Bool) -> Void)) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations: {
            //self.centerController.view.layoutIfNeeded()
            self.currentVC!.view.frame.origin.x = x
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow : Bool ) {
        if shouldShowShadow {
            currentVC!.view.layer.shadowOpacity = 0.8
        } else {
            currentVC!.view.layer.shadowOpacity = 0.0
        }
    }
}
