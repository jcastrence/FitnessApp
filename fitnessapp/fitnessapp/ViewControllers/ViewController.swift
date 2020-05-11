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
    @IBOutlet weak var inputErrorLabel: UILabel!
    
    var userUID: String!
    var email: String!
    var password: String!
    var logInSuccessful: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    func segueToSignUp() {
        performSegue(withIdentifier: "SignUp", sender: nil)
    }
    
    
    @IBAction func logInTapped(_ sender: Any) {
        // Make sure fields are good
        if let error = validateFields() {
            self.inputErrorLabel.text = error
            return
        }
        // Log In user
        logInUser()
        if logInUser() == true {
            goToFeed()
        }
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
    
    func validateFields() -> String? {
        if let email = emailField.text, let password = passwordField.text {
            if !isValidEmail(email) {
                return "Invalid email address"
            }
            if !isValidPassword(password) {
                return "Invalid password"
            }
            self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            self.password = password
            return nil
        }
        else {
            return "Please enter all fields"
        }
    }
    
    // Functions for checking email, password, and name of user
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        if password.count < 8 {
            return false
        }
        return true
    }
    
    // Function to sign in user using Firebase
    func logInUser() -> Bool {
        Auth.auth().signIn(withEmail: self.email, password: self.password) { (result, err) in
            if err != nil {
                self.inputErrorLabel.text = "Invalid user log in"
                self.logInSuccessful = false
                return
            }
            else {
                self.logInSuccessful = true
                return
            }
        }
        self.logInSuccessful = true
        return self.logInSuccessful
    }
    
}

