import SwiftUI
import RealityKit
import ARKit
import UIKit

class Coordinator: NSObject, ARCoachingOverlayViewDelegate {
    @Binding var palpites: [Int]
    weak var timer: TimerController?
    weak var gameplayViewModel: GameplayViewModel?
    weak var gameController: GameController?
    weak var audioPlayer: AudioPlayer?
    var jogaEmAndamento = false
    
    init(palpites: Binding<[Int]>,
         timer: TimerController,
         gameplayViewModel: GameplayViewModel,
         audioPlayer: AudioPlayer?,
         gameController: GameController?){
        self._palpites = palpites
        self.timer = timer
        self.gameplayViewModel = gameplayViewModel
        self.audioPlayer = audioPlayer
        self.gameController = gameController
    }
    
    public func addCoaching(view:ARView) {
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = view.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .horizontalPlane
        view.addSubview(coachingOverlay)
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //Ready to add entities next?
        timer?.startTimer()
    }
    
    
    public func onTapAction(objectToMove: Entity, arView: ARView, invisibleObject: Entity){
        Container.objToMove = objectToMove
        Container.arView = arView
        Container.invisibleObject = invisibleObject
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(reconizer:)))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(reconizer: UITapGestureRecognizer){
        print("clicou na Tela")
        let objectToMove = Container.objToMove
        let arView = Container.arView
        let invisibleObject = Container.invisibleObject
        
        //usa o toque para encontrar a posicao como CGPoint
        let location = reconizer.location(in: arView)
        
        if let entity = arView!.entity(at: location){
            if entity.name.contains("Slot"){
                let index = extractNumber(from: entity.name)
                jogada(index: index!, objectToMove: objectToMove!, targetEntity: entity, returnPositionEntity: invisibleObject!)
            }
        } else {
            print("No hit")
        }
    }
    
    func moveObject(objectToMove: Entity, targetEntity: Entity, scale: SIMD3<Float>, duration: TimeInterval){
        objectToMove.move(to: Transform(scale: scale,
                                        translation: [0,0,0]),
                          relativeTo: targetEntity,
                          duration: duration)
    }
    
    func extractNumber(from slotString: String) -> Int? {
        let components = slotString.components(separatedBy: CharacterSet.decimalDigits.inverted)
        let numbers = components.compactMap { Int($0) }
        return numbers.first
    }
    
    func jogada(index: Int, objectToMove: Entity, targetEntity: Entity, returnPositionEntity: Entity){
        
        if !jogaEmAndamento{
            self.jogaEmAndamento = true
            self.moveObject(objectToMove: objectToMove, targetEntity: targetEntity, scale: [0.04, 0.04, 0.04], duration: 1.0)
            audioPlayer!.playEffect(effect: "soccer-kick", type: "mp3", volume: 7.0)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                if let gameController = self.gameController,
                   let gameplayViewModel = self.gameplayViewModel {
                    if (index == gameplayViewModel.palpiteCorreto){
                        
                        self.audioPlayer?.playEffect(effect: "goal-scream", type: "mp3", volume: 2.0)
                        gameController.armazenarResultado(ResultadoJogada.acertou)
                        
                    } else {
                        
                        gameController.armazenarResultado(ResultadoJogada.errou)
                        self.audioPlayer?.playEffect(effect: "missed-goal", type: "mp3", volume: 0.8)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        
                        gameplayViewModel.iniciarJogada(operacao: gameplayViewModel.operacao[gameController.indiceFaseJogo])
                        self.moveObject(objectToMove: objectToMove, targetEntity: returnPositionEntity, scale: [1/0.04, 1/0.04, 1/0.04], duration: 0.001)
                        self.jogaEmAndamento = false
                    }
                    
                }
            }
        }
    }
    
    
}
