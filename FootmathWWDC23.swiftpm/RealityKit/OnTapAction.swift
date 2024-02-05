import SwiftUI
import RealityKit
import ARKit
import UIKit

//class Container {
//    static var objToMove: Entity?
//    static var scale: SIMD3<Float>?
//    static var arView: ARView?
//}

//extension ARView {
//    
//    func onTapAction(objectToMove: Entity, ballScale: SIMD3<Float>){
//        Container.objToMove = objectToMove
//        Container.scale = ballScale
//        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(reconizer:)))
//        self.addGestureRecognizer(tapGestureRecognizer)
//    }
//    
//    @objc func handleTap(reconizer: UITapGestureRecognizer){
//        print("clicou na Tela")
//        let objectToMove = Container.objToMove
//        let scale = Container.scale
//        
//        //usa o toque para encontrar a posicao como CGPoint
//        let location = reconizer.location(in: self)
//        
//        if let entity = self.entity(at: location){
//            if entity.name.contains("Slot"){
//                self.moveObject(objectToMove: objectToMove!, scale: scale!, targetEntity: entity)
//            }
//        } else {
//            print("No hit")
//        }
//    }
//    
//    func moveObject(objectToMove: Entity, scale: SIMD3<Float>, targetEntity: Entity){
//        objectToMove.move(to: Transform(scale: [0.04, 0.04, 0.04],
//                                        translation: [0,0,0]),
//                                        relativeTo: targetEntity,
//                                        duration: 1.0)
//    }
//    
//    func jogada(index: Int){
//        audioPlayer.playEffect(effect: "soccer-kick", type: "mp3", volume: 7.0)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            if (index == gameplayViewModel.palpiteCorreto){
//                audioPlayer.playEffect(effect: "goal-scream", type: "mp3", volume: 2.0)
//                gameController.armazenarResultado(ResultadoJogada.acertou)
//            } else {
//                gameController.armazenarResultado(ResultadoJogada.errou)
//                audioPlayer.playEffect(effect: "missed-goal", type: "mp3", volume: 0.8)
//            }
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                gameplayViewModel.iniciarJogada(operacao: gameplayViewModel.operacao[gameController.indiceFaseJogo])
//
//            }
//        }
//    }
//    
//}
