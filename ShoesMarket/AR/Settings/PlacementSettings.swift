//
//  PlacementSettings.swift
//  ShoesMarket
//
//  Created by Дарья Федяшова on 30.01.2022.
//

import Foundation
import Combine

class PlacementSettings: ObservableObject{
    @Published var selectedModel: ARModel?{
        willSet(newValue){
            print("new value")
        }
    }
    @Published var confirmedModel: ARModel?{
        willSet(newValue){
            print("new value")
        }
    }
    var sceneObserver: Cancellable?
    
}
