//
//  VirtualObject+Text.swift
//  SaveEarthApp!
//
//  Created by 鬼澤　吾門 on 2022-12-16.
//

import Foundation
import ARKit
import RealityKit

extension VirtualObject {
    func addTextPlateModel(_ text: String, offset: Float, extrusionDepth: Float, fontSize: CGFloat, color: UIColor) {
        let textMesh = MeshResource.generateText(text, extrusionDepth: extrusionDepth, font: .systemFont(ofSize: fontSize), containerFrame: .zero, alignment: .left, lineBreakMode: .byWordWrapping)
        let textMaterial = UnlitMaterial(color: color)
        let textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])
        
        let textWidth = (textMesh.bounds.max.x) - (textMesh.bounds.min.x)
        let textHeight = (textMesh.bounds.max.y) - (textMesh.bounds.min.y)
        
        let plateMesh = MeshResource.generatePlane(width: textWidth+0.06, height: textHeight+0.06, cornerRadius: textWidth/12)
        //let plateMesh = MeshResource.generatePlane(width: 0.15, height: textHeight+0.06)
        let plateMaterial = UnlitMaterial(color: .white)
        let plateModel = ModelEntity(mesh: plateMesh, materials: [plateMaterial])
        
        modelEntity = plateModel
        plateModel.position = simd_make_float3(0, offset, 0)
        
        plateModel.addChild(textModel)
        
        let center = textMesh.bounds.center
        textModel.position = [-center.x, -center.y, extrusionDepth/2]
        
        modelAnchor.addChild(plateModel)
    }
}
