//
//  ARCameraView.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 06.12.2021.
//

import SwiftUI
import RealityKit

struct ARCameraView: View {
    
    // MARK: - PROPERTIES
    @StateObject var ps = PlacementSettings()
    @Environment(\.presentationMode) var presentationMode
    var nameARModel: String
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
                
            ControlView()
        } //: ZSTACK
        .environmentObject(ps)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            let item = ARModel(name: nameARModel, scaleCompensation: 1)
            item.asyncLoadModelEntity()
            
            self.ps.selectedModel = item
        }
        .onDisappear {
            self.ps.selectedModel = nil
            self.ps.confirmedModel = nil
        }
    }
    
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var placementSettings: PlacementSettings
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero)
        self.placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { event in
            self.updateScene(for: arView)
        })
        return arView
    }

    func updateUIView(_ uiView: CustomARView, context: Context) {}

    
    private func updateScene(for arView: CustomARView){
        arView.focusEntity?.isEnabled = self.placementSettings.selectedModel != nil
        
        if let confirmedModel = self.placementSettings.confirmedModel, let modelEntity = confirmedModel.modelEntity{
            self.place(modelEntity, in: arView)
            self.placementSettings.confirmedModel = nil
        }
    }
    
    private func place(_ modelEntity: ModelEntity, in arView: ARView){
        let clonedEntity = modelEntity.clone(recursive: true)
        clonedEntity.generateCollisionShapes(recursive: true)
        arView.installGestures([.translation, .rotation, .scale], for: clonedEntity)
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        
        arView.scene.addAnchor(anchorEntity)
    }
}
