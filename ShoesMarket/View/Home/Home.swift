//
//  Home.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 06.08.2021.
//

import SwiftUI
import Firebase

struct Home: View {
    
    // MARK: - PROPERTIES
    
    @AppStorage("log_Status") var status = false
    @StateObject private var state = StateModel()

    
    // MARK: - BODY
    
    var body: some View {
    
        ZStack {
            VStack(spacing: 0) {
                
                NavigationBarView(state: state)
                    .padding(.horizontal, 15)
                    .padding(.bottom)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 0) {
                        
                        // Slider
                        FeaturedTabView()
                            .padding(.vertical, 20)
                            .frame(height: 270)
                        
                        // Category
                        CategoryGridView(state: state)
                        
                        // Footer
                        FooterView()
                            .padding(.horizontal)
                        
                        // Sign Out
                        VStack(spacing: 15) {
                            Text("Успешный вход")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            
                            Button(action: {
                                // Loggin out
                                try? Auth.auth().signOut()
                                withAnimation{status = false}
                            }, label: {
                                Text("Выйти")
                                    .fontWeight(.heavy)
                            })
                            
                        } //: VSTACK
                    } //: VSTACK
                }) //: SCROLL
                
            } //: VSTACK
            .background(colorBackground.ignoresSafeArea(.all, edges: .all))
            .fullScreenCover(item: $state.fullScreenToShow, content: { content in
                content
            })
        } //: ZTACK
        .ignoresSafeArea(.all, edges: .top)
        
    }
}

// MARK: - PROPERTIES

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
