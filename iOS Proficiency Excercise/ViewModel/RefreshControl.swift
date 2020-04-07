//
//  RefreshControl.swift
//  iOS Proficiency Excercise
//
//  Created by Vino on 4/7/20.
//  Copyright © 2020 Vino. All rights reserved.
//

import UIKit

/**
The RefreshControl used tfor set the custom Pull-to-Refresh Action
*/

class RefreshControl: UIRefreshControl {

    private weak var actionTarget: AnyObject?
    private var actionSelector: Selector?
    override init() { super.init() }

    convenience init(actionTarget: AnyObject?, actionSelector: Selector) {
        self.init()
        self.actionTarget = actionTarget
        self.actionSelector = actionSelector
        addTarget()
    }

    private func addTarget() {
        guard let actionTarget = actionTarget, let actionSelector = actionSelector else { return }
        addTarget(actionTarget, action: actionSelector, for: .valueChanged)
    }

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    func endRefreshing(deadline: DispatchTime? = nil) {
        guard let deadline = deadline else { endRefreshing(); return }
        DispatchQueue.global(qos: .default).asyncAfter(deadline: deadline) { [weak self] in
            DispatchQueue.main.async { self?.endRefreshing() }
        }
    }

    func refreshActivityIndicatorView() {
        guard let selector = actionSelector else { return }
        let _isRefreshing = isRefreshing
        removeTarget(actionTarget, action: selector, for: .valueChanged)
        endRefreshing()
        if _isRefreshing { beginRefreshing() }
        addTarget()
    }

    func generateRefreshEvent() {
        beginRefreshing()
        sendActions(for: .valueChanged)
    }
}
