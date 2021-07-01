//
//  UIViewController + Utilities.swift
//  wongyhelpers
//
//  Created by Samuel Wong on 28/6/21.
//

import UIKit

extension UIViewController {
    func addKeyboardListeners(willShowSelector: Selector? = nil, didShowSelector: Selector? = nil, willHideSelector: Selector? = nil, didHideSelector: Selector? = nil) {
        if let selector = willShowSelector {
            NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardWillShowNotification, object: nil)
        }
        
        if let selector = didShowSelector {
            NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardDidShowNotification, object: nil)
        }
        
        if let selector = willHideSelector {
            NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        if let selector = didHideSelector {
            NotificationCenter.default.addObserver(self, selector: selector, name: UIResponder.keyboardDidHideNotification, object: nil)
        }
    }
    
    func setupBackButtonToolbar(toolbar: UIView) {
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: toolbar.frame.height))
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(conveniencePopViewController), for: .touchUpInside)
        toolbar.addSubview(backButton)
    }
    
    @objc private func conveniencePopViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func convenienceDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addBackgroundViewDismissKeyboardRecognizer(delegate: UIGestureRecognizerDelegate? = nil) {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        if let delegate = delegate {
            gestureRecognizer.delegate = delegate
        }
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupStatusBarColour(colour: UIColor) {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = colour
        self.view.addSubview(statusBarView)
    }
    
    func isEditing() -> Bool {
        return UIViewController.recursiveCheckForEditing(view: self.view)
    }
    
    private static func recursiveCheckForEditing(view: UIView) -> Bool {
        if let textfield = view as? UITextField {
            if textfield.isFirstResponder {
                return true
            }
        } else if let textview = view as? UITextView {
            if textview.isFirstResponder {
                return true
            }
        }
        
        if view.subviews.count > 0 {
            for subview in view.subviews {
                if recursiveCheckForEditing(view: subview) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func showUIViewAsAlert(alertView: UIView) {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundView.addBlurryBackground(withColour: UIColor.gray)
        backgroundView.addSubview(alertView)
        backgroundView.alpha = 0
        self.view.addSubview(backgroundView)
        
        backgroundView.animateHidden(hidden: false)
    }
    
    func dismissUIViewAsAlert(alertView: UIView) {
        let backgroundView = alertView.superview!
        backgroundView.animateHidden(hidden: true, completionBlock: { () -> Void in
            backgroundView.removeFromSuperview()
        })
    }

    
    func showSlideInView(withPopupView popupView: ((_ frame: CGRect) -> UIView), forcingFrame: CGRect? = nil, vertically: Bool = false) {
        let offset:CGFloat = 8
        
        var frame: CGRect!
        if vertically {
            frame = CGRect(x: offset, y: self.view.frame.size.height, width: self.view.frame.size.width - 2*offset, height: 3*(self.view.frame.size.height/4))
        } else {
            if #available(iOS 11.0, *) {
                frame = CGRect(x: self.view.frame.width, y: UIApplication.shared.statusBarFrame.height, width: 3*self.view.frame.width/8, height: self.view.frame.height - UIApplication.shared.statusBarFrame.height - self.view.safeAreaInsets.bottom)
            } else {
                frame = CGRect(x: self.view.frame.width, y: UIApplication.shared.statusBarFrame.height, width: 3*self.view.frame.width/8, height: self.view.frame.height - UIApplication.shared.statusBarFrame.height)
            }
        }
        let popupView = popupView(forcingFrame ?? frame)
        
        let backgroundView = UIView(frame: self.view.frame)
        backgroundView.addBlurryBackground(withColour: UIColor.gray)
        backgroundView.alpha = 0
        
        self.view.addSubview(backgroundView)
        backgroundView.addSubview(popupView)
        
        backgroundView.animateHidden(hidden: false) {
            UIView.animate(withDuration: 0.4) {
                if vertically {
                    popupView.frame = CGRect(x: popupView.frame.origin.x, y: backgroundView.frame.height - (popupView.frame.height - 8), width: popupView.frame.size.width, height: popupView.frame.size.height)
                } else {
                    popupView.frame = CGRect(x: self.view.frame.width - popupView.frame.size.width, y: popupView.frame.origin.y, width: popupView.frame.size.width, height: popupView.frame.size.height)
                }
            }
        }
    }
    
    func dismissSlideInView(slideInView: UIView, vertically: Bool = true) {
        let backgroundView = slideInView.superview!
        
        UIView.animate(withDuration: 0.4) {
            if vertically {
                slideInView.frame = CGRect(x: slideInView.frame.origin.x, y: self.view.frame.size.height, width: slideInView.frame.size.width, height: slideInView.frame.size.height)
            } else {
                slideInView.frame = CGRect(x: self.view.frame.size.width, y: slideInView.frame.origin.y, width: slideInView.frame.size.width, height: slideInView.frame.size.height)
            }

        } completion: { completed in
            backgroundView.animateHidden(hidden: true)
        }
    }
    
    func createBottomSafeAreaView(withColour colour: UIColor) {
        if #available(iOS 11.0, *) {
            if self.view.safeAreaInsets.bottom != 0 {
                let bottomView = UIView(frame: CGRect(x: 0, y: self.view.frame.height - self.view.safeAreaInsets.bottom, width: self.view.frame.width, height: self.view.safeAreaInsets.bottom))
                bottomView.backgroundColor = colour
                self.view.addSubview(bottomView)
            }
        }
    }
    
    func safeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaInsets
        } else {
            return UIEdgeInsets.zero
        }
    }
}
