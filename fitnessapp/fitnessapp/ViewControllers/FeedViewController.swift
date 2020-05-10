//
//  FeedViewController.swift
//  fitnessapp
//
//  Copyright © 2020 Julian Castrence. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
	
	var messagesController: MessagesController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		overrideUserInterfaceStyle = .dark
    }
    

	@IBAction func messageButton(_ sender: Any) {
		let messagesController = MessagesController()
		let navController = UINavigationController(rootViewController: messagesController)
		present(navController, animated: true, completion: nil)
		print("button pressed")
	}
	
	func switchToMessages() {
		print("switch")
		self.messagesController?.fetchUserAndSetupNavBarTitle()
		self.dismiss(animated: true, completion: nil)
    }
	
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
