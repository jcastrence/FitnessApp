//
//  SignUpViewController.swift
//  fitnessapp
//
//  Copyright © 2020 Julian Castrence and Henry Wang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var inputErrorLabel: UILabel!
    @IBOutlet weak var profileTypeSegControl: UISegmentedControl!
    
    var userUID: String!
    var email: String!
    var password: String!
    var name: String!
    var isTrainee: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signUpBackPressed(_ sender: Any) {
        performSegue(withIdentifier: "Index", sender: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        // Make sure fields are good
        if let error = validateFields() {
            self.inputErrorLabel.text = error
            return
        }
        // If fields are good, create a new user
        createNewUser(self.email, self.password, self.name, self.isTrainee)
        // User has been created, go the the feed
        goToFeed()
    }
    
    func validateFields() -> String? {
        self.inputErrorLabel.text = ""
        if let email = emailField.text, let password = passwordField.text, let name = nameField.text {
            if !isValidEmail(email) {
                return "Invalid email address"
            }
            if !isValidPassword(password) {
                return "Password must be at least 8 characters"
            }
            if !isValidName(name) {
                return "Enter a name containing only letters"
            }
            self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            self.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
            switch profileTypeSegControl.selectedSegmentIndex {
            case 0:
                self.isTrainee = true
            default:
                self.isTrainee = false
            }
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
    
    func isValidName(_ name: String) -> Bool {
        if name.count < 1 {
            return false
        }
        for letter in name {
          if (!(letter >= "a" && letter <= "z") && !(letter >= "A" && letter <= "Z") ) {
             return false
          }
       }
       return true
    }
    
    func isValidPassword(_ password: String) -> Bool {
        if password.count < 8 {
            return false
        }
        return true
    }
    
    // Function to create a new user
    func createNewUser(_ email: String, _ password: String, _ name: String, _ isTrainee: Bool) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            // Check for errors
            if err != nil {
                // Error trying to create user
                self.inputErrorLabel.text = "There was an error trying to create this user."
            }
            else {
                let db = Firestore.firestore()
                let userData: [String:Any] = [
                    "uid": result!.user.uid, "email": email, "password": password, "name": name, "isTrainee": isTrainee
                ]
                print(userData)
                db.collection("users").addDocument(data: userData) { (err) in
                    if err != nil {
                        self.inputErrorLabel.text = "There was an error adding this user to the database."
                    }
                }
            }
        }
    }
    
    // Function to take user the feed page
    func goToFeed() {
        let feedViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.feedViewController) as? FeedViewController
        
        view.window?.rootViewController = feedViewController
        view.window?.makeKeyAndVisible()
    }
    
}
