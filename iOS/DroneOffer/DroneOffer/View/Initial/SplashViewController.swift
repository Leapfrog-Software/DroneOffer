//
//  SplashViewController.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    enum ResultKey {
        case user
        case offer
    }

    private var results = Dictionary<ResultKey, Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.fetch()
        })
    }
    
    private func fetch() {
        
        self.results.enumerated().forEach { i, result in
            if result.value == false {
                self.results[result.key] = nil
            }
        }
        
        if self.results[.user] != true {
            FetchUserRequester.shared.fetch(completion: { [weak self] result in
                self?.results[.user] = result
                self?.checkResult()
            })
        }
        if self.results[.offer] != true {
            FetchOfferRequester.shared.fetch(completion: { [weak self] result in
                self?.results[.offer] = result
                self?.checkResult()
            })
        }
    }
    
    private func checkResult() {
        
        let keys: [ResultKey] = [.user, .offer]
        let results = keys.map { self.results[$0] }
        if results.contains(where: { $0 == nil }) {
            return
        }
        if results.contains(where: { $0 == false }) {
            self.showError()
        } else {
            let tabbar = self.viewController(storyboard: "Initial", identifier: "TabbarViewController") as! TabbarViewController
            self.stack(viewController: tabbar)
        }
    }
    
    private func showError() {
        let action = DialogAction(title: "リトライ", action: { [weak self] in
            self?.fetch()
        })
        Dialog.show(style: .error, title: "エラー", message: "通信に失敗しました", actions: [action])
    }
    
    private func stack(viewController: UIViewController) {
        
        let blackView = UIView(frame: CGRect(origin: .zero, size: self.view.frame.size))
        blackView.backgroundColor = .black
        blackView.alpha = 0.0
        self.view.addSubview(blackView)
        
        UIView.animate(withDuration: 0.2, animations: {
            blackView.alpha = 1.0
        }, completion: { [weak self] _ in
            self?.stack(viewController: viewController, animationType: .none)
            self?.view.bringSubview(toFront: blackView)
            
            UIView.animate(withDuration: 0.2, animations: {
                blackView.alpha = 0.0
            }, completion: { _ in
                blackView.removeFromSuperview()
            })
        })
    }
}
