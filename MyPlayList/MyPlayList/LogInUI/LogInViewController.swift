//
//  LogInViewController.swift
//  MyPlayList
//
//  Created by Capgemini on 12/3/19.
//  Copyright © 2019 Capgemini. All rights reserved.
//

import UIKit
import Foundation

class LogInViewController: UIViewController {

    @IBOutlet weak var emailId : UITextField!
    @IBOutlet weak var password : UITextField!
    private var logInViewModel = LogInViewModel()
    private var userEmail : String!
    private var userPassword : String!
    override func viewDidLoad() {
        super.viewDidLoad()
         }
    
    override func viewWillAppear(_ animated: Bool)
    {
         super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    

    private func userAuthentication(_ userEmail: String , _ userPassword : String) {
        if logInViewModel.authenticateUser(user(email: userEmail,password: userPassword)) {
            switchScreen()
        } else {
            displayAlertMsg("Enter valid userId or password.")
        }
    }
  
     private func switchScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SongsTableViewController") as? SongsTableViewController {
            self.navigationController!.pushViewController(viewController, animated: true)
            //self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClickLogInBtn(_ sender: Any) {
         userEmail = emailId.text!
         userPassword = password.text!
         if userEmail.isEmpty || userPassword.isEmpty {
            displayAlertMsg("Email or password field can't be empty.")
        }
        else {
       userAuthentication(userEmail,userPassword)
    }
    }
    
    private func displayAlertMsg(_ userMsg : String) {
        let myAlert = UIAlertController(title: "Alert" , message: userMsg, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert,animated: true, completion: nil)
        }
    
        // return
        
    }
