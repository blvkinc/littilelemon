//
//  viewModel.swift
//  LittleLemonApp
//
//  Created by Jevgeni Vakker on 25.03.2023.
//

import Foundation
import Combine

public let key_Name = "key_Name"
public let key_Email = "key_Email"
public let key_IsLoggedIn = "key_IsLoggedIn"


public let key_OrderStatuses = "key_OrderStatuses"
public let key_PasswordCh = "key_PasswordCh"
public let key_SpecialOffers = "key_SpecialOffers"
public let key_NewsLetter = "key_NewsLetter"

class ViewModel: ObservableObject {
    
    @Published var name = UserDefaults.standard.string(forKey: key_Name) ?? ""
    @Published var email = UserDefaults.standard.string(forKey: key_Email) ?? ""
    
    @Published var orderStatuses = UserDefaults.standard.bool(forKey: key_OrderStatuses)
    @Published var passwordChanges = UserDefaults.standard.bool(forKey: key_PasswordCh)
    @Published var specialOffers = UserDefaults.standard.bool(forKey: key_SpecialOffers)
    @Published var newsletter = UserDefaults.standard.bool(forKey: key_NewsLetter)
    
    
    @Published var isErrorMessageVisible = false
    @Published var errorMessageText = ""
    
    @Published var searchText = ""
    
    func validateUserInput(name: String, email: String) -> Bool {
        guard !name.isEmpty && !email.isEmpty else {
            errorMessageText = "Please eneter your name and email"
            isErrorMessageVisible = true
            return false
        }
        
        if(!isValidEmailAddr(strToValidate: email)) {
            errorMessageText = "Invalid email."
            isErrorMessageVisible = true;
            return false;
        }
        
        isErrorMessageVisible = false
        errorMessageText = ""
        return true
    }
    
    func isValidEmailAddr(strToValidate: String) -> Bool {
      let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"  // 1

      let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2

      return emailValidationPredicate.evaluate(with: strToValidate)  // 3
    }
}
