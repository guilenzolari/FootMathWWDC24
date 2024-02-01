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
        print(location)
        
        if let entity = self.entity(at: location){
            print("Entity name:\(entity.name)")
            
            
            if let anchorEntity = entity.anchor, anchorEntity.name.contains("Slot"){
                print("clicou no botao e reconheceu que é o slot: \(entity.name)")
            }
            print(entity.name)
        } else {
            print("No hit")
        }
    }
}
