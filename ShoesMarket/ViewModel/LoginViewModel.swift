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
    @Published var errorMsg = ""
    @Published var error = false
    // Хранение кода для верификации пользователя
    @Published var CODE = ""
    @Published var gotoVerify = false
    // Статус пользователя
    @AppStorage("log_Status") var status = false
    @Published var loading = false
    
    // Получение кода страны пользователя
    func getCountryCode() -> String {
        
        let regionCode = Locale.current.regionCode ?? ""
        return countries[regionCode] ?? ""
        
    }
    
    // Отправка кода пользователю для подтверждения
    func sendCode() {
        // Enabling testing code
        // Disable when you need to test with real device
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        //getCountryCode()
        let number = "+7\(phoneNumber)"
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
    
    // Проверка кода пользователя
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

            withAnimation{self.status = true}
            
        }
    }
    
    // Отправить код повторно
    func requestCode() {
        sendCode()
        withAnimation {
            self.errorMsg = "Код отправлен повторно"
            self.error.toggle()
        }
    }
    
}
