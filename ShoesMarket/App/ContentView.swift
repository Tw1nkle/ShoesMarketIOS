//
//  ContentView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 03.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @AppStorage("log_Status") var status = false
    
    // MARK: - BODY
    
    var body: some View {
        if status {
            Home()
        } else {
            NavigationView {
                Login()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
