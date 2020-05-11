//
//  FeedViewController.swift
//  fitnessapp
//
//  Copyright © 2020 Julian Castrence. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FeedViewController: UIViewController {
	
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var accountTypeSegControl: UISegmentedControl!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    var messagesController: MessagesController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		overrideUserInterfaceStyle = .dark
        getUserInfo()
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
    
    func getUserInfo() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
        
        if let dictionary = snapshot.value as? [String: AnyObject] {
            
            let user = User(dictionary: dictionary)
            self.emailTextField.text = user.email
            self.nameTextField.text = user.name
        }
        
        }, withCancel: nil)
        
    }
    
    
    @IBAction func updateAccountTapped(_ sender: Any) {
    
    }
    
}
