//
//  LoginViewModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 04.08.2021.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    
    @Published var phoneNumber = ""
    
    @Published var code = ""
    
    // Getting country phone code
    
    // DataModel for view
    
    @Published var errorMsg = ""
    @Published var error = false
    
    // Storing code for verification
    
    @Published var CODE = ""
    
    @Published var gotoVerify = false
    
    // User logged status
    
    @AppStorage("log_Status") var status = false
    
    // Loading view
    
    @Published var loading = false
    
    
    func getCountryCode() -> String {
        
        let regionCode = Locale.current.regionCode ?? ""
        return countries[regionCode] ?? ""
        
    }
    
    // Sending code to user
    
    func sendCode() {
        
        // Enabling testing code
        // Disable when you need to test with real device
        
        //Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let number = "+\(getCountryCode())\(phoneNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) {
            (CODE, err) in
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation{self.error.toggle()}
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
        }
    }
    
    func verifyCode() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        loading = true
        
        Auth.auth().signIn(with: credential) { (result, err) in
            
            self.loading = false
            
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation{self.error.toggle()}
                return
            }
            
            // Else user logged in successfully
            
            withAnimation{self.status = true}
            
        }
    }
    
    func requestCode() {
        sendCode()
        withAnimation {
            self.errorMsg = "Код отправлен повторно"
            self.error.toggle()
        }
    }
    
}
