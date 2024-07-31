//
//  ARContainerViewController+Objects.swift
//  SaveEarthApp!
//
//  Created by 鬼澤　吾門 on 2022-12-16.
//

import Foundation
import ARKit
import RealityKit

extension ARContainerViewController {
    func planeIsDetected(planeAnchor: AnchorEntity) {
        let objectAndMessage: Dictionary<String, String> = [
            "Computer": "COMPUTER \nTurn off your computer \nand monitor when not \nin use! Use power \nmanagement settings!",
            "Tissue Paper": "TISSUE PAPER \nTry recycling or composting \nused tissue paper instead \nof just throwing it away!",
            "Towel": "TOWEL \nCotton towel is the best \noption for the environment! \nTry to avoid using towels \ncontaining micro-fibres!",
            "Plastic Bottle": "PLASTIC BOTTLE \nTry to avoid buying plastic \nbottles and use your own \nwater bottle!",
            "Tooth Brush": "TOOTH BRUSH \nTry using toothbrush made \nof bamboo! It will reduce \nthe amount of plastic waste \nand also can be composted!",
        ]
        
        let object: String = objectAndMessage.keys.randomElement() ?? "Plastic Bottle"
   
        var orientation = arView.cameraTransform.rotation
        orientation.vector.x = 0
        orientation.vector.z = 0
        planeAnchor.orientation = orientation
        
        
        itemObject = VirtualObject(modelAnchor: planeAnchor)
        itemObject?.loadModel(name: object, nameExtension: "usdz") { isSuccessed in
            if isSuccessed {
            } else {
                print("The object couldn't be loaded")
            }
        }
        
        let objectExtent: Float? = itemObject?.modelEntity?.visualBounds(relativeTo: itemObject?.modelEntity).extents.y
        
        let offset = (objectExtent ?? 0.20) + 0.1
        
        labelObject = VirtualObject(modelAnchor: planeAnchor)
        labelObject?.addTextPlateModel(objectAndMessage[object] ?? "PLASTIC BOTTLE \nTry to avoid buying plastic \nbottles and use your own \nwater bottle!", offset: offset, extrusionDepth: 0.001, fontSize: 0.015, color: UIColor(white: 0.2, alpha: 1.0))
        
        self.arView.scene.addAnchor(planeAnchor)
    }
}

