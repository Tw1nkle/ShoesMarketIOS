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
    
    @State var text = ""
    var placeText = "+7"
    
    // MARK: - PREVIEW
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Авторизация")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding()
                    
                    Image("phoneVerify")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text("Вы получите 6-значный код\nдля подтверждения аккаунта")
                        .font(isSmall ? .none : .system(size: 20.0))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    // Поле для ввода номера мобильного телефона
                    HStack {
                        VStack(alignment: .leading, spacing: 11) {
                            Text("Введите номер телефона")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                            
                            if loginData.phoneNumber.isEmpty {
                                Text(placeText)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black.opacity(0.5))
                                    .font(.title2)
                            } else {
//                                loginData.getCountryCode()
                                Text("+7 \(loginData.phoneNumber.formatPhone())")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                    .onChange(of: loginData.phoneNumber) { value in
                                        if value.count > 10{
                                            loginData.phoneNumber.removeLast()
                                        }
                                    }
                            }
                            
                        
                                
                        } //: VSTACK
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink(
                            destination: Verification(loginData: loginData), isActive: $loginData.gotoVerify) {
                            Text("")
                                .hidden()
                        }
                        Button(action: loginData.sendCode, label: {
                            Text("Далее")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 36)
                                .background(buttonColor)
                                .cornerRadius(10)
                                .font(.system(size: 16))
                        })
                        .disabled(loginData.phoneNumber == "" ? true : false)
                    } //: HSTACK
                    .padding()
                    .padding(.leading, 8)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    
                } //: VSTACK
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(colorBackground.ignoresSafeArea())
                
                // Кастомная клавиатура
                CustomNumberPad(value: $loginData.phoneNumber, isVerify: false)
                
            } //: VSTACK
            .background(Color.gray.opacity(0.2).ignoresSafeArea(.all, edges: .bottom))
            
            if loginData.error {
                AlertView(message: loginData.errorMsg, show: $loginData.error)
            }
        } //: ZTACK
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
