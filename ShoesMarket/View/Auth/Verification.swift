//
//  Verification.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 05.08.2021.
//

import SwiftUI

struct Verification: View {
    
    // MARK: - PROPERTIES
    @ObservedObject var loginData: LoginViewModel
    @Environment(\.presentationMode) var present
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Button(action: {present.wrappedValue.dismiss()}) {
                            Image(systemName: "chevron.backward")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("Код из СМС")
                            .font(.title2)
                            .fontWeight(.heavy)
                        
                        Spacer()
                        
                        if loginData.loading{ProgressView()}
                        
                    } //: HSTACK
                    .padding()
                    
                    Text("Код отправлен на +\(loginData.getCountryCode()) \(loginData.phoneNumber)")
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 15) {
                        ForEach(0..<6, id: \.self) { index in
                            CodeView(code: getCodeAtIndex(index: index))
                        }
                    } //: HSTACK
                    .padding()
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6) {
                        Text("Не получили код?")
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                        
                        Button(action: loginData.requestCode) {
                            Text("Запросить новый код")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                        }
                    } //: HSTACK
                    
                    Button(action: loginData.verifyCode) {
                        Text("Подтвердить")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 100)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(buttonColor)
                            .cornerRadius(10)
                            .font(.system(size: 16))
                    }
                    .padding()
                    
                } //: VSTACK
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(colorBackground.ignoresSafeArea())
                
                CustomNumberPad(value: $loginData.code, isVerify: true)
            } //: VSTACK
            .background(Color.gray.opacity(0.2).ignoresSafeArea(.all, edges: .bottom))
            
            if loginData.error {
                AlertView(message: loginData.errorMsg, show: $loginData.error)
            }
        } //: ZTACK
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    // Получение кода по каждому индексу
    func getCodeAtIndex(index: Int) -> String {
        if loginData.code.count > index {
            let start = loginData.code.startIndex
            
            let current = loginData.code.index(start, offsetBy: index)
            
            return String(loginData.code[current])
        }
        
        return ""
    }
}

struct CodeView: View {
    
    // MARK: - PROPERTIES
    var code: String
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 10) {
            Text(code)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title2)
                .frame(height: 45)
        
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        } //: VSTACK
    }
}
