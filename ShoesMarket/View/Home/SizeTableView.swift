//
//  SizeTableView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 13.12.2021.
//

import SwiftUI

struct SizeTableView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        VStack {
            
            Text("Таблица соответствия размеров")
                .font(.title3)
                .fontWeight(.heavy)
                .padding(.top, 30)
                .padding(.bottom, 50)
            
            HStack(alignment: .center) {
                
                Text("Размер")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.4))
                
                Spacer()
                
                Text("См")
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.4))
                
            } //: HSTACK
            .padding(.leading, 60)
            .padding(.trailing, 80)
            .padding(.bottom, 25)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(sizes) { size in
                    HStack(alignment: .center, spacing: 0) {
                        
                        Text(size.globalSize)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        
                        Text(size.centimeters)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                        
                    } //: HSTACK
                    .padding()
                    
                    Divider()
                        .padding(.leading)
                        .padding(.trailing)
                }
            }
            
        } //: VSTACK
    }
}

// MARK: - PREVIEW
struct SizeTableView_Previews: PreviewProvider {
    static var previews: some View {
        SizeTableView()
    }
}
