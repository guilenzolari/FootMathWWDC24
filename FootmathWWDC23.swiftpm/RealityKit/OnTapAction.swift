import SwiftUI
import RealityKit
import ARKit
import UIKit

class Container {
    static var objToMove: Entity?
    static var scale: SIMD3<Float>?
}

extension ARView {
    
    func onTapAction(objectToMove: Entity, ballScale: SIMD3<Float>){
        Container.objToMove = objectToMove
        Container.scale = ballScale
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(reconizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(reconizer: UITapGestureRecognizer){
        print("clicou na Tela")
        let objectToMove = Container.objToMove
        let scale = Container.scale
        
        //usa o toque para encontrar a posicao como CGPoint
        let location = reconizer.location(in: self)
        
        if let entity = self.entity(at: location){

            if entity.name.contains("Slot"){
                self.moveObject(objectToMove: objectToMove!, scale: scale!, targetEntity: entity)
                print("Clicou em um objeto Slot")
            }
        } else {
            print("No hit")
        }
    }
    
    func moveObject(objectToMove: Entity, scale: SIMD3<Float>, targetEntity: Entity){
        objectToMove.move(to: Transform(scale: [0.04, 0.04, 0.04], translation: [0,0,0]),
                          relativeTo: targetEntity,
                          duration: 1.0)
    }
}
