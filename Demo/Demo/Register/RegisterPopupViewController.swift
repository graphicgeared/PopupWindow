//
//  RegisterPopupViewController.swift
//  Demo
//
//  Created by Shinji Hayashi on 2018/03/03.
//  Copyright © 2018年 shin884. All rights reserved.
//


import UIKit
import PopupWindow

class RegisterPopupViewController: BasePopupViewController {
    enum Const {
        static let popupDuration: TimeInterval = 0.3
        static let transformDuration: TimeInterval = 0.4
        static let maxWidth: CGFloat = 500
        static let landscapeSize: CGSize = CGSize(width: maxWidth, height: 249)
        static let popupOption = PopupOption(shapeType: .roundedCornerTop(cornerSize: 8), viewType: .toast, direction: .bottom)
        static let popupCompletionOption = PopupOption(shapeType: .roundedCornerTop(cornerSize: 8), viewType: .toast, direction: .bottom, hasBlur: false)
    }

    private let registerPopupView = RegisterPopupView.view()
    private let registerPopupCompletionView = RegisterPopupCompletionView.view()

    override func viewDidLoad() {
        super.viewDidLoad()

        let popupItem = PopupItem(view: registerPopupView, height: RegisterPopupView.Const.height, maxWidth: Const.maxWidth, landscapeSize: Const.landscapeSize, popupOption: Const.popupOption)
        configurePopupItem(popupItem)

        registerPopupView.closeButtonTapHandler = { [weak self] in
            self?.dismissPopupView(duration: Const.popupDuration, curve: .easeInOut, direction: .bottom) { _ in }
        }

        registerPopupView.registerButtonTapHandler = { [weak self] in
            guard let me = self else { return }
            me.showCompletionView()
        }
    }

    private func showCompletionView() {
        let popupItem = PopupItem(view: registerPopupCompletionView, height: RegisterPopupCompletionView.Const.height, maxWidth: Const.maxWidth, popupOption: Const.popupCompletionOption)
        transformPopupView(duration: Const.transformDuration, curve: .easeInOut, popupItem: popupItem) { [weak self] _ in
            guard let me = self else { return }
            me.replacePopupView(with: popupItem)
            me.dismissPopupView(duration: 3.3, curve: .easeInOut, delayFactor: 0.9, direction: .bottom) { _ in
                PopupWindowManager.shared.changeKeyWindow(rootViewController: nil)
            }
        }
    }
}

