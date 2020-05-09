//
//  ViewController.swift
//  fitnessapp
//
//  Copyright © 2020 Julian Castrence and Henry Wang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var userUID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUp" {
            if let destination = segue.destination as? SignUpViewController {
                if userUID != nil {
                    destination.userUID = userUID;
                }
//                if let inputEmail = emailField.text {
//                    destination.emailField = inputEmail
//                }
//                if let inputPassword = passwordField.text {
//                    destination.passwordField = inputPassword
//                }
            }
        }
    }
    
//    @IBAction func signInOrUpTapped(_ sender: Any) {
//        if let email = emailField.text {
//            if let password = passwordField.text {
//                Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//                  guard let strongSelf = self else { return }
//                  // ...
//                }
//            }
//            else {
//                self.segueToSignUp();
//            }
//        }
//    }
    
    
    
    func segueToSignUp() {
        performSegue(withIdentifier: "SignUp", sender: nil)
    }

    @IBAction func signUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "SignUp", sender: nil)
    }
    
    // Function to take user the feed page
    func goToFeed() {
        let feedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.feedViewController) as? FeedViewController
        
        view.window?.rootViewController = feedViewController
        view.window?.makeKeyAndVisible()
    }
    
}

