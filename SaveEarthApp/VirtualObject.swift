//
//  VirtualObject.swift
//  SaveEarthApp!
//
//  Created by 鬼澤　吾門 on 2022-12-16.
//

import RealityKit
import ARKit
import Combine

class VirtualObject {
    var modelAnchor: AnchorEntity
    var modelEntity: ModelEntity?
    var cancellable: AnyCancellable?
    
    init(modelAnchor: AnchorEntity) {
        self.modelAnchor = modelAnchor
    }
    
    func loadModel(name: String, nameExtension: String, completion: @escaping (Bool) -> Void) {
        guard let url = Bundle.main.url(forResource: name, withExtension: nameExtension) else {
            completion(false)
            return
        }
        
        cancellable = Entity.loadModelAsync(contentsOf: url, withName: nil)
            .sink(receiveCompletion: { loadCompletion in
                if case let .failure(error) = loadCompletion {
                    print(error.localizedDescription)
                    completion(false)
                } else {
                    completion(true)
                }
            }, receiveValue: { [weak self] model in
                self?.modelEntity = model
                self?.modelAnchor.addChild(model)
            })
    }
}


