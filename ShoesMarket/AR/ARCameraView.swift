//
//  ARCameraView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 06.12.2021.
//

import SwiftUI
import RealityKit

struct ARCameraView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var nameARModel: String
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            ARViewContainer()
            
            ControlView()
            
        } //: ZTACK
        .edgesIgnoringSafeArea(.all)
        
    }
    
}

struct ARViewContainer: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

}

//struct ARCameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARCameraView()
//
//    }
//}
