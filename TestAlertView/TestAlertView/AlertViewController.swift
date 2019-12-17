//
//  AlertViewController.swift
//  TestAlertView
//
//  Created by Matic Oblak on 17/12/2019.
//  Copyright © 2019 Matic Oblak. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet private var blurView: UIVisualEffectView?
    @IBOutlet private var dialogPanel: UIView?
    @IBOutlet private var titleLabel: UILabel? // Is in vertical stack view
    @IBOutlet private var messageLabel: UILabel? // Is in vertical stack view
    @IBOutlet private var okButton: UIButton? // Is in horizontal stack view
    @IBOutlet private var cancelButton: UIButton? // Is in horizontal stack view

    var titleText: String?
    var messageText: String?
    var confirmButtonText: String?
    var cancelButtonText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        setHiddenState(isHidden: true, animated: false) // Initialize as not visible

        titleLabel?.text = titleText
        titleLabel?.isHidden = !(titleText?.isEmpty == false)

        messageLabel?.text = messageText
        messageLabel?.isHidden = !(messageText?.isEmpty == false)

        okButton?.setTitle(confirmButtonText, for: .normal)
        okButton?.isHidden = !(confirmButtonText?.isEmpty == false)

        cancelButton?.setTitle(cancelButtonText, for: .normal)
        cancelButton?.isHidden = !(cancelButtonText?.isEmpty == false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setHiddenState(isHidden: false, animated: true)
    }

    private func setHiddenState(isHidden: Bool, animated: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            self.blurView?.effect = isHidden ? UIVisualEffect() : UIBlurEffect(style: .light)
            self.dialogPanel?.alpha = isHidden ? 0.0 : 1.0
        }) { _ in
            completion?()
        }
    }

    @IBAction private func okPressed() {
        AlertViewController.dismissAlert()
    }
    @IBAction private func cancelPressed() {
        AlertViewController.dismissAlert()
    }


}

// MARK: - Window

extension AlertViewController {

    private static var currentAlert: (window: UIWindow, controller: AlertViewController)?

    static func showMessage(_ message: String) {

        guard currentAlert == nil else {
            print("An alert view is already shown. Dismiss this one to show another.")
            return
        }

        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        controller.confirmButtonText = "OK"
        controller.messageText = message

        
        let window: UIWindow
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.windows.first!.windowScene!
            window = UIWindow(windowScene: scene)
        } else {
            // Fallback on earlier versions
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        
        window.windowLevel = .alert
        window.rootViewController = controller
        window.makeKeyAndVisible()

        self.currentAlert = (window, controller)
    }

    static func dismissAlert() {
        if let currentAlert = self.currentAlert {
            currentAlert.controller.setHiddenState(isHidden: true, animated: true) {
                self.currentAlert?.window.isHidden = true
                self.currentAlert = nil
            }
        }
    }

}
