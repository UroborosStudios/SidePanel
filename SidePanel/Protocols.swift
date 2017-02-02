//
//  Protocols.swift
//  sidePanel
//
//  Created by Jonathan  Silva on 01/02/17.
//  Copyright © 2017 Sye. All rights reserved.
//

import Foundation

@objc
public protocol SidePanelDelegate {
    @objc func panelWillShow()
    @objc func panelDidShow()
    @objc func panelWillHide()
    @objc func panelDidHide()
}

public protocol MainVCDelegate {
    func togglePanel(panel: Panel)
    func closePanels(complete: @escaping ()->Void)
}
