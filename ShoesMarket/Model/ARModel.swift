//
//  ARModel.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 30.01.2022.
//

import Foundation
import RealityKit
import Combine

class ARModel {
    var name: String
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, scaleCompensation: Float) {
        self.name = name
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        print(filename)
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink { loadCompletion in
                switch loadCompletion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Ok")
                    break
                }
            } receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
            }

    }
}
