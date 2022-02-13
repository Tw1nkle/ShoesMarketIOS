//
//  ProductMainDetailView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 12.12.2021.
//

import SwiftUI
import RealmSwift
import RealityKit

struct ProductMainDetailView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var shopData: ShopViewModel
    @EnvironmentObject var state: StateModel
    @StateObject var ShopModel = ShopViewModel()
    @State private var showARView: Bool = false
    @State private var showSizeTable: Bool = false
    var animation: Namespace.ID
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                        shopData.showCart.toggle()
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                } //: HSTACK
                .padding()
                .padding(.top, 50)
                
                // Картинка
                Image(shopData.selectedProduct?.image ?? sampleProduct.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360, alignment: .center)
                    .padding(.bottom, 40)
                
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 7) {
                            HStack {
                                // Главный заговолок
                                Text("New Balance")
                                    .font(.system(size: 22))
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Button {
                                    DispatchQueue.main.async {
                                        showARView = true
                                    }
                                    print("selected \(shopData.selectedProduct?.name ?? sampleProduct.name)")
                                } label: {
                                    ZStack {
                                        // VR
                                        Circle()
                                            .foregroundColor(buttonColor)
                                            .frame(width: 50, height: 50)
                                        
                                        Image("vr360")
                                    } //: ZTACK
                                }
                                .fullScreenCover(isPresented: $showARView) {
                                    ARCameraView(nameARModel: shopData.selectedProduct?.name ?? sampleProduct.name)
                                }
                                .padding(.top, 4)

                            } //: HSTACK
                            .padding(.top, -20)
                            
                            // Заголовок
                            Text("Кроссовки \(shopData.selectedProduct?.name ?? sampleProduct.name)")
                                .font(.system(size: 16))
                                .padding(.top, -15)
                            
                            // Подзаголовок
                            Text("\(shopData.selectedProduct?.gender ?? sampleProduct.gender) кроссовки")
                                .font(.system(size: 12))
                                .foregroundColor(Color.black.opacity(0.5))
                            
                            HStack {
                                // Цена
                                Text("\(shopData.selectedProduct?.discountPrice ?? sampleProduct.discountPrice) ₽")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor((shopData.selectedProduct?.discount ?? sampleProduct.discount) > 0 ? discountColor : Color.black)
                                    .padding(.top, 10)
                                
                                // Скидочная цена
                                Text((shopData.selectedProduct?.discount ?? sampleProduct.discount) > 0 ? "\(shopData.selectedProduct?.formattedPrice ?? sampleProduct.formattedPrice) ₽" : " ")
                                    .font(.system(size: 11))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black.opacity(0.4))
                                    .strikethrough(true, color: .gray)
                                    .padding(.top, 5)
                                
                                // Скидка
                                if (shopData.selectedProduct?.discount ?? sampleProduct.discount) > 0 {
                                    Text("-\(shopData.selectedProduct?.discount ?? sampleProduct.discount)%")
                                        .font(.system(size: 10))
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .background(discountColor)
                                        .cornerRadius(10)
                                }
                            } //: HSTACK
                            
                            // Раздел
                            Text("Размеры")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            
                            // Размеры
                            LazyVGrid(columns: columnSize, alignment: .leading, spacing: 15) {
                                ForEach(shopData.selectedProduct?.sizes ?? sampleProduct.sizes, id: \.self) { size in
                                    Button {
                                        withAnimation {
                                            shopData.selectedSize = size
                                        }
                                    } label: {
                                        Text(size)
                                            .font(.system(size: 16))
                                            .fontWeight(.heavy)
                                            .foregroundColor(shopData.selectedSize == size ? .white : .black)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(shopData.selectedSize == size ? buttonColor : Color.black.opacity(0.06))
                                            .cornerRadius(15)
                                    }
                                }
                            } //: LAZYVGRID
                            
                            // Таблица размеров
                            Button {
                                showSizeTable.toggle()
                            } label: {
                                Text("Таблица размеров")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.black)
                                    .underline()
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 15)
                            
                            // Добавить в корзину
                            Button {
                                withAnimation(.easeInOut(duration: 0.7)) {
                                    shopData.startAnimation = true
                                }
                                shopData.productName = shopData.selectedProduct?.name ?? sampleProduct.name
                                shopData.productImage = shopData.selectedProduct?.image ?? sampleProduct.image
                                shopData.productPrice = shopData.selectedProduct?.discountPrice ?? sampleProduct.discountPrice
                                shopData.productCode = shopData.selectedProduct?.code ?? sampleProduct.code
                                shopData.productColor = shopData.selectedProduct?.color ?? sampleProduct.color
                                shopData.formattedPrice = shopData.selectedProduct?.formattedPrice ?? sampleProduct.formattedPrice
                                shopData.addData()
                                print(Realm.Configuration.defaultConfiguration.fileURL as Any)
                            } label: {
                                Text("Добавить в корзину")
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(shopData.selectedSize == "" ? .black : .white)
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(shopData.selectedSize == "" ? Color.black.opacity(0.06) : buttonColor)
                                    .cornerRadius(10)
                            }
                            .disabled(shopData.selectedSize == "")
                            
                            // Раздел
                            Text("О товаре")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                            
                            VStack(alignment: .leading) {
                                // Артикул
                                Text("Артикул")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black.opacity(0.5))
                                Text(shopData.selectedProduct?.code ?? sampleProduct.code)
                                    .padding(.bottom, 1)
                                
                                // Цвет
                                Text("Цвет")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black.opacity(0.5))
                                Text(shopData.selectedProduct?.color ?? sampleProduct.color)
                                    .padding(.bottom, 1)
                                
                                // Материал верха
                                Text("Материал верха")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black.opacity(0.5))
                                Text(shopData.selectedProduct?.topMaterial ?? sampleProduct.topMaterial)
                                    .padding(.bottom, 1)
                                
                                // Внутренний материал
                                Text("Внутренний материал")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black.opacity(0.5))
                                Text(shopData.selectedProduct?.innerMaterial ?? sampleProduct.innerMaterial)
                                    .padding(.bottom, 1)
                                
                                // Страна производства
                                Text("Страна производства")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.black.opacity(0.5))
                                Text(shopData.selectedProduct?.country ?? sampleProduct.country)
                                    .padding(.bottom, 1)
                            } //: VSTACK
                            .font(.system(size: 12))
                        } //: VSTACK
                        .padding()
                    }
                    .padding(.top, 20)
                } //: VSTACK
                .background(Color.white)
                .cornerRadius(45)
                .ignoresSafeArea()
                .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 0)
            } //: VSTACK
            .sheet(isPresented: $showSizeTable) {
                SizeTableView()
            }
        } //: ZTACK
        .background(colorBackground.ignoresSafeArea())
    }
}
