//
//  TabbarViewController.swift
//  DroneOffer
//
//  Created by Leapfrog-Software on 2018/10/10.
//  Copyright © 2018 Leapfrog-Inc. All rights reserved.
//

import UIKit

class TabbarViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    
    private var userListViewController: UserListViewController!
    private var messageViewController: MessageViewController!
    private var myPageViewController: MyPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initContents()
    }
    
    private func initContents() {
        
        self.userListViewController = self.viewController(storyboard: "Offer", identifier: "UserListViewController") as! UserListViewController
        self.addContent(self.userListViewController)
        self.messageViewController = self.viewController(storyboard: "Message", identifier: "MessageViewController") as! MessageViewController
        self.addContent(self.messageViewController)
        self.myPageViewController = self.viewController(storyboard: "MyPage", identifier: "MyPageViewController") as! MyPageViewController
        self.addContent(self.myPageViewController)
        
        self.changeContent(index: 0)
    }
    
    private func addContent(_ viewController: UIViewController) {
        
        self.containerView.addSubview(viewController.view)
        self.addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    }
    
    private func changeContent(index: Int) {
        
        self.userListViewController.view.isHidden = (index != 0)
        self.messageViewController.view.isHidden = (index != 1)
        self.myPageViewController.view.isHidden = (index != 2)
    }
    
    @IBAction func onTapTab1(_ sender: Any) {
        self.changeContent(index: 0)
    }
    
    @IBAction func onTapTab2(_ sender: Any) {
        self.changeContent(index: 1)
    }
    
    @IBAction func onTapTab3(_ sender: Any) {
        self.changeContent(index: 2)
    }
}
