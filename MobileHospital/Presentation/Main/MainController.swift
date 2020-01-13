//
//  NavigationViewController.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import UIKit

class MainController: UINavigationController, MainView {

    lazy var presenter = MainPresenter(viewState: self)
    
    var preloaderView: UIView? = nil
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.green
        self.setBackButton()
        presenter.viewDidLoad(controller: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.viewWillDisappear()
    }
    
    func showMessage(_ message: String) {
        showToast(message: message)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let loaderFrame = preloaderView?.frame {
            if UIDevice.current.orientation.isLandscape {
                let frame = CGRect.init(x: 0, y: 0, width: loaderFrame.height, height: loaderFrame.width)
                preloaderView?.frame = frame
            } else {
                let frame = CGRect.init(x: 0, y: 0, width: loaderFrame.height, height: loaderFrame.width)
                preloaderView?.frame = frame
            }
        }
    }
    
    func showLoader() {
        if preloaderView != nil {
            hideLoader()
            showLoader()
        } else {
            let loaderView = UIView.init(frame: self.view.frame)
            loaderView.center = self.view.center;
            let backgroundColor = UIColor.init(red:216/255.0, green:216/255.0, blue:216/255.0, alpha:0.45);
            loaderView.backgroundColor = backgroundColor
            preloaderView = loaderView
            view.addSubview(loaderView)
            loaderView.bringSubviewToFront(self.view)
            KVSpinnerView.show(on: loaderView)
        }
    }
    
    func hideLoader() {
        preloaderView?.removeFromSuperview()
        preloaderView = nil
    }
    
    private func showToast(message : String) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 17.5;
        toastLabel.clipsToBounds  =  true
        
        let font: UIFont = UIFont.systemFont(ofSize: 12.0)
        toastLabel.font = font
        let fontAttributes = [NSAttributedString.Key.font: font]
        let stringBoundingBox = (message as NSString).size(withAttributes: fontAttributes);
        let xPosition: CGFloat = max(10, self.view.frame.size.width/2 - stringBoundingBox.width/2 - 5)
        let widthToast: CGFloat = min(stringBoundingBox.width + 10, self.view.frame.width - 20)
        toastLabel.frame = CGRect(x: xPosition, y: self.view.frame.size.height-100, width: widthToast, height: 35)
        
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

