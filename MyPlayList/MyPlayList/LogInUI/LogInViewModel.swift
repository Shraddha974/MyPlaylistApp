//
//  File.swift
//  MyPlayList
//
//  Created by Capgemini on 12/3/19.
//  Copyright © 2019 Capgemini. All rights reserved.
//

import Foundation

class LogInViewModel {

   func authenticateUser(_ user: user) -> Bool {
        if isValidEmail(user.email) {
            if isValidPassword(user.password) {
                return true
            }
            else {
                return false
            }
        }else {
            return false
        }
    }
    
   private func isValidEmail(_ email : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
        
    }
    
     private func isValidPassword(_ password : String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
           let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
           return passwordTest.evaluate(with: password)
       }
}
