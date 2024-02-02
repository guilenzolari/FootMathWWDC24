import SwiftUI
import RealityKit
import ARKit
import UIKit

class Container {
    static var objToMove: Entity?
}

extension ARView {
    
    func onTapAction(objectToMove: Entity){
        Container.objToMove = objectToMove
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(reconizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(reconizer: UITapGestureRecognizer){
        print("clicou na Tela")
        let location = reconizer.location(in: self)
        let objectToMove = Container.objToMove
        
        if let entity = self.entity(at: location){
            if entity.name.contains("Slot"){
                print("Clicou em um objeto Slot")
                self.moveObject(objectToMove: objectToMove!, position: .init(x: 1, y: 1, z: 1))
            }
        } else {
            print("No hit")
        }
    }
    
    func moveObject(objectToMove: Entity, position: SIMD3<Float>){
        objectToMove.move(to: Transform(translation: position),
                    relativeTo: nil,
                    duration: 1.0,
                    timingFunction: .easeInOut)
    }
}
