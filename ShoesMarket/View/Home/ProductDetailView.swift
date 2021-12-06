//
//  ProductDetailView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 23.08.2021.
//

import SwiftUI
import RealmSwift

struct ProductDetailView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var shopData: ShopViewModel
    @StateObject var ShopModel = ShopViewModel()
    var animation: Namespace.ID
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                if !shopData.startAnimation {
                    // Изображение
                    Image(shopData.selectedProduct?.image ?? sampleProduct.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "SHOE", in: animation)
                        .padding(.horizontal)
                }
                
                VStack(alignment: .trailing, spacing: 5, content: {
                    
                    // Название
                    Text(shopData.selectedProduct?.name ?? sampleProduct.name)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    
                    // Пол
                    Text(shopData.selectedProduct?.gender ?? sampleProduct.gender)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    
                    // Work
                    // "\(sampleProduct.discountPrice) ₽"
                    // String(shopData.selectedProduct?.discountPrice ?? sampleProduct.discountPrice)
                    
                    // Цена
                    Text("\(shopData.selectedProduct?.discountPrice ?? sampleProduct.discountPrice) ₽")
                        .font(.system(size: 22))
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                }) //: VSTACK
            } //: HSTACK
            .padding()
            
            Divider()
            
            Text("Выберите размер")
                .font(.system(size: 16))
                .foregroundColor(.black.opacity(0.5))
                .fontWeight(.semibold)
                .padding(.top, 25)
                .padding(.bottom)
            
            // Список размеров
            LazyVGrid(columns: columnSize, alignment: .leading, spacing: 15, content: {
                ForEach(shopData.selectedProduct?.sizes ?? sampleProduct.sizes, id: \.self) { size in
                    Button(action: {
                        withAnimation{
                            shopData.selectedSize = size
                        }
                    }, label: {
                        Text(size)
                            .font(.system(size: 18))
                            .fontWeight(.heavy)
                            .foregroundColor(shopData.selectedSize == size ? .white : .black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(shopData.selectedSize == size ? buttonColor : Color.black.opacity(0.06))
                            .cornerRadius(15)
                    }) //: BUTTON
                    
                }
            }) //: LAZY
            
            // Кнопка для добавления товара в корзину
            Button(action: {
                withAnimation(.easeInOut(duration: 0.7)) {
                    shopData.startAnimation = true
                    shopData.productName = shopData.selectedProduct?.name ?? sampleProduct.name
                    shopData.productImage = shopData.selectedProduct?.image ?? sampleProduct.image
                    shopData.productPrice = shopData.selectedProduct?.discountPrice ?? sampleProduct.discountPrice
                    shopData.addData()
                }
                print(Realm.Configuration.defaultConfiguration.fileURL as Any)
            }, label: {
                Text("Добавить в корзину")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(shopData.selectedSize == "" ? .black : .white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(shopData.selectedSize == "" ? Color.black.opacity(0.06) : buttonColor)
                    .cornerRadius(10)
            }) //: BUTTON
            .disabled(shopData.selectedSize == "")
            .padding(.top)
            
            Button {} label: {
                HStack {
                    Image(systemName: "arkit")
                        .foregroundColor(.white)
                    
                    Text("Примерить обувь")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(10)
            }
            .padding(.top, 10)

            
        } //: VSTACK
        .padding()
        .padding(.bottom, 20)
        .background(Color.white.clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 35)))
    }
}
