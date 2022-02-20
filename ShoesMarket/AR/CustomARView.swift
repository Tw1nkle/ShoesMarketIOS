//
//  CustomARView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 30.01.2022.
//

import Foundation
import RealityKit
import ARKit
import FocusEntity


// MARK: - Focus View

class CustomARView: ARView{
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        focusEntity = FocusEntity(on: self, focus: .classic)
        print(focusEntity ?? "No focus entity")
        configure()
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        session.run(config)
    }
}
