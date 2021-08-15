//
//  Login.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 04.08.2021.
//

import SwiftUI

struct Login: View {
    
    // MARK: - PROPERTIES
    
    @StateObject var loginData = LoginViewModel()
    @State var isSmall = UIScreen.main.bounds.height < 750
    
    // MARK: - PREVIEW
    
    var body: some View {
        
        ZStack {
            VStack {
                VStack {
                    Text("Авторизация")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                    
                    Image("phoneVerify")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text("Вы получите 6-значный код\nдля подтверждения аккаунта.")
                        .font(isSmall ? .none : .title2)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    // Mobile number field
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Введите номер телефона")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("+ \(loginData.getCountryCode()) \(loginData.phoneNumber)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        } //: VSTACK
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink(
                            destination: Verification(loginData: loginData), isActive: $loginData.gotoVerify) {
                            Text("")
                                .hidden()
                        }
                        Button(action: loginData.sendCode, label: {
                            Text("Далее")
                                .foregroundColor(.black)
                                .padding(.vertical, 18)
                                .padding(.horizontal, 38)
                                .background(Color.yellow)
                                .cornerRadius(15)
                        })
                        .disabled(loginData.phoneNumber == "" ? true : false)
                    } //: HSTACK
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    
                } //: VSTACK
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(20)
                
                // Custom number pad
                
                CustomNumberPad(value: $loginData.phoneNumber, isVerify: false)
                
            } //: VSTACK
            .background(Color.gray.opacity(0.2).ignoresSafeArea(.all, edges: .bottom))
            
            if loginData.error {
                AlertView(message: loginData.errorMsg, show: $loginData.error)
            }
        } //: ZTACK
        
    }
}
