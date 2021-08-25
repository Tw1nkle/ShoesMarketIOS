//
//  SearchView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 08.08.2021.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var shopData: ShopViewModel
    @State private var isEditing = false
    
    // MARK: - BODY
    
    var body: some View {
    
        ZStack {
            VStack {
                HStack {
                    TextField("Поиск", text: $shopData.searchQuery)
                        .padding(15)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 15)
                                
                                if isEditing {
                                    Button(action: {
                                        shopData.searchQuery = ""
                                    }, label: {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    })
                                }
                            }
                        )
                        .onTapGesture {
                            self.isEditing = true
                        }
                    
                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Text("Отменить")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .onTapGesture {
                                    presentationMode.wrappedValue.dismiss()
                                }
                        })
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                    
                } //: HSTACK
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    // Product
                    LazyVGrid(columns: gridLayoutVertical, spacing: 15, content: {
                        ForEach(products.filter({"\($0)".contains(shopData.searchQuery) || shopData.searchQuery.isEmpty})) { product in
                            ProductItemView(product: product)
                        } //: LOOP
                    }) //: GRID
                    .padding(15)
                }
            } //: VSTACK
        } //: ZTACK
        
    }
}

// MARK: - PREVIEW

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ShopViewModel())
    }
}
