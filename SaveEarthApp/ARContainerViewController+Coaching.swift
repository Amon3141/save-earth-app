//
//  ARContainerViewController+Coaching.swift
//  SaveEarthApp!
//
//  Created by 鬼澤　吾門 on 2022-12-16.
//

import Foundation
import ARKit

extension ARContainerViewController: ARCoachingOverlayViewDelegate {
    func setupCoachingOverlay() {
        coachingOverlay.session = arView.session
        
        coachingOverlay.delegate = self
        
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        arView.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: arView.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: arView.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: arView.heightAnchor)
        ])
        
        coachingOverlay.activatesAutomatically = true
        
        coachingOverlay.goal = .horizontalPlane
    }
    
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) {
        resetTracking()
    }
}


