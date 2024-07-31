//
//  ARContainerViewController.swift
//  SaveEarthApp!
//
//  Created by 鬼澤　吾門 on 2022-12-16.
//

import UIKit
import ARKit
import RealityKit

class ARContainerViewController: UIViewController, ARSessionDelegate {
    
    var arView: ARView!
    
    var coachingOverlay = ARCoachingOverlayView()
    
    var resetButton = UIButton()
    
    var itemObject: VirtualObject?
    var labelObject: VirtualObject?
    
    override func loadView() {
        self.view = UIView(frame: .zero)
        
        arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false )
        
        arView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arView)
        
        NSLayoutConstraint.activate([
            arView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            arView.widthAnchor.constraint(equalTo: view.widthAnchor),
            arView.topAnchor.constraint(equalTo: view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        arView.session.delegate = self
        
        setupCoachingOverlay()
        
        addResetButton()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        arView.addGestureRecognizer(tap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        resetTracking()
        
        UIApplication.shared.isIdleTimerDisabled = true;
    }
    
    
    func resetTracking() {
        let config = ARWorldTrackingConfiguration()
        
        config.planeDetection = [.horizontal]
        
        if let objects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: nil) {
            config.detectionObjects = objects
        }
        
        arView.scene.anchors.removeAll()
        
        arView.session.run(config, options: [.removeExistingAnchors, .resetTracking])
    }
    
    
    func addResetButton() {
        resetButton.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(UIColor(white: 0.10, alpha: 1.0), for: .normal)
        resetButton.frame = CGRectMake(UIScreen.main.bounds.size.width-95, 50, 80, 35)
        //resetButton.layer.borderWidth = 1.0
        //resetButton.layer.borderColor = UIColor(white: 0.10, alpha: 1.0).cgColor
        resetButton.layer.cornerRadius = 10.0
        
        arView.addSubview(resetButton)
        resetButton.addTarget(self, action: #selector(tapResetButton(_:)), for: .touchUpInside)
    }
    
    @objc func tapResetButton(_ sender: UIButton) {
        resetTracking()
    }
    
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended else {
            return
        }
        
        let location = gesture.location(in: arView)
        
        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        
        if results.count > 0 {
            //let anchor = AnchorEntity(raycastResult: results[0])
            let anchor = AnchorEntity()
            planeIsDetected(planeAnchor: anchor)
            print("Plane is detected")
        }
    }
    
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .normal:
            break
        default:
            break
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else {
            return
        }
        
        var message = (error as NSError).localizedDescription
        if let reason = (error as NSError).localizedFailureReason {
            message += "\n\(reason)"
        }
        if let suggestion = (error as NSError).localizedRecoverySuggestion {
            message += "\n\(suggestion)"
        }
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "ARSession Failed", message: message, preferredStyle: .alert)
            let reset = UIAlertAction(title: "Reset Tracking", style: .default) { _ in
                self.resetTracking()
            }
            
            alert.addAction(reset)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        
    }
    
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return false
    }
}

