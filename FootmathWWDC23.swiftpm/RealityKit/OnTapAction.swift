import SwiftUI
import RealityKit
import ARKit
import UIKit

extension ARView {
        
    func onTapAction(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(reconizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(reconizer: UITapGestureRecognizer){
        print("clicou na Tela")
        let location = reconizer.location(in: self)
        
        if let entity = self.entity(at: location){
            if entity.name.contains("Slot"){
                print("Clicou em um objeto Slot")
                moveObject(object: entity, position: .init(x: 1, y: 1, z: 1))
            }
            print(entity.name)
        } else {
            print("No hit")
        }
    }
    
    func moveObject(object: Entity, position: SIMD3<Float>){
        object.move(to: Transform(translation: position),
                    relativeTo: nil,
                    duration: 1.0,
                    timingFunction: .easeInOut)
    }
}
