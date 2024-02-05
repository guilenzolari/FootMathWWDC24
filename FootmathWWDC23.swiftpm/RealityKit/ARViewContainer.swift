import SwiftUI
import RealityKit
import ARKit
import UIKit

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var palpites: [Int]
    weak var timer: TimerController?
    weak var gameplayViewModel: GameplayViewModel?
    
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController: GameController
    
    let boxMaterial = SimpleMaterial(color: .lightGray, isMetallic: false)
    let textMaterial = SimpleMaterial(color: .black, isMetallic: false)
    let anchorPlane = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
    let anchorScaleGoal: SIMD3<Float> = [2.4, 2.0, 2.0]
    let ballEntityScale: SIMD3<Float> = [0.02, 0.02, 0.02]
    let anchorScaleBall: SIMD3<Float> = [2.0, 2.0, 2.0]
    let goalEntityScale: SIMD3<Float> = [0.05, 0.05, 0.05]
    let goalPosition: SIMD3<Float> = [0, 0, -0.25]
    let boxPosition: [SIMD3<Float>] = [[-0.2, 0.29, -0.35],
                                       [0, 0.29, -0.35],
                                       [0.2, 0.29, -0.35],
                                       [-0.2, 0.1, -0.35],
                                       [0, 0.1, -0.35],
                                       [0.2, 0.1, -0.35]]
    var ballPosition: SIMD3<Float> = [0, -0.01, 0.5]
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        context.coordinator.addCoaching(view:arView)
        
        //arView.debugOptions = [.showPhysics, .showAnchorGeometry, .showFeaturePoints]
        
        anchorPlane.name = "AnchorPlane"
        
        // Bola
        let ballEntity = makeObject(arView: arView,
                                    name: "ball.usdc",
                                    entityScale: ballEntityScale,
                                    anchorScale: anchorScaleBall,
                                    position: ballPosition)
        
        // Trave
        _ = makeObject(arView: arView,
                       name: "gol.usdc",
                       entityScale: goalEntityScale,
                       anchorScale: anchorScaleGoal,
                       position: goalPosition)
        
        arView.scene.addAnchor(anchorPlane)
        
        for index in 0...5 {
            
            // Botões
            let boxEntity = makeBox(arView: arView,
                                    name: "Slot \(index)",
                                    position: boxPosition[index])
            
            //Textos
            makeText(arView: arView,
                     text: "\(palpites[index])",
                     index: index ,
                     textMaterial: textMaterial,
                     dadEntity: boxEntity)
        }
        
        context.coordinator.onTapAction(objectToMove: ballEntity, ballScale: ballEntityScale, arView: arView)
        
        return arView
    }
    
    //from SWiftUI to UIKit
    func updateUIView(_ arView: ARView, context: Context) {
        
        let anchorSlots = arView.scene.anchors.filter { element in
            return element.name.contains("AnchorPlane")}
        
        let slots = anchorSlots.first?.children.filter { element in
            return element.name.contains("Slot")}
        
        if let slots {
            
            for slot in slots {
                
                let texts = slot.children.filter { element in
                    element.name.contains("Text")}
                
                if let textEntity = texts.first {
                    
                    let index = Int(textEntity.name.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
                    
                    if let index {
                        textEntity.removeFromParent()
                        makeText(arView: arView,
                                 text: "\(palpites[index])",
                                 index: index ,
                                 textMaterial: textMaterial, dadEntity: slot)
                    }
                }
            }
        }
    }
    
    //from UIKit to SwifUi
    func makeCoordinator() -> Coordinator {
        return Coordinator(palpites: $palpites,
                           timer: timer!,
                           gameplayViewModel: gameplayViewModel!,
                           audioPlayer: audioPlayer,
                           gameController: gameController)
    }
    
    class Coordinator: NSObject, ARCoachingOverlayViewDelegate {
        @Binding var palpites: [Int]
        weak var timer: TimerController?
        weak var gameplayViewModel: GameplayViewModel?
        weak var gameController: GameController?
        weak var audioPlayer: AudioPlayer?
        
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
        
        
        public func onTapAction(objectToMove: Entity, ballScale: SIMD3<Float>, arView: ARView){
            Container.objToMove = objectToMove
            Container.scale = ballScale
            Container.arView = arView
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(reconizer:)))
            arView.addGestureRecognizer(tapGestureRecognizer)
        }
        
        @objc func handleTap(reconizer: UITapGestureRecognizer){
            print("clicou na Tela")
            let objectToMove = Container.objToMove
            let scale = Container.scale
            let arView = Container.arView
            
            //usa o toque para encontrar a posicao como CGPoint
            let location = reconizer.location(in: arView)
            
            if let entity = arView!.entity(at: location){
                if entity.name.contains("Slot"){
                    let index = extractNumber(from: entity.name)
                    jogada(index: index!, objectToMove: objectToMove!, targetEntity: entity)
                }
            } else {
                print("No hit")
            }
        }
        
        func moveObject(objectToMove: Entity, targetEntity: Entity){
            objectToMove.move(to: Transform(scale: [0.04, 0.04, 0.04],
                                            translation: [0,0,0]),
                              relativeTo: targetEntity,
                              duration: 1.0)
        }
        
        func extractNumber(from slotString: String) -> Int? {
            let components = slotString.components(separatedBy: CharacterSet.decimalDigits.inverted)
            let numbers = components.compactMap { Int($0) }
            return numbers.first
        }
        
        func jogada(index: Int, objectToMove: Entity, targetEntity: Entity){
            
            self.moveObject(objectToMove: objectToMove, targetEntity: targetEntity)
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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        
                        gameplayViewModel.iniciarJogada(operacao: gameplayViewModel.operacao[gameController.indiceFaseJogo])
                        //fazer bola voltar a posicao inicial
                    }
                    
                }
            }
        }
    }
    
    func makeObject(arView: ARView, name: String, entityScale: SIMD3<Float>, anchorScale: SIMD3<Float>, position: SIMD3<Float>) -> Entity {
        let entity = try! ModelEntity.load(named: name)
        let anchor = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0,0]))
        entity.scale = entityScale
        anchor.addChild(entity)
        anchor.position = position
        anchor.scale = anchorScale
        arView.scene.addAnchor(anchor)
        
        return entity
    }
    
    func makeText(arView: ARView, text: String, index: Int, textMaterial: SimpleMaterial, dadEntity: Entity){
        let textMesh = MeshResource.generateText(text, extrusionDepth: 0.1, font: .systemFont(ofSize: 3.5), alignment: .center)
        let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
        textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
        textEntity.position = [-0.05, -0.06, 0.01]
        textEntity.name = "Text \(index)"
        dadEntity.addChild(textEntity)
    }
    
    func makeBox(arView: ARView, name: String, position: SIMD3<Float>) -> Entity{
        let box = MeshResource.generateBox(width: 0.16, height: 0.15, depth: 0.01)
        let boxEntity = ModelEntity(mesh: box, materials: [boxMaterial])
        boxEntity.name = name
        boxEntity.generateCollisionShapes(recursive: true)
        boxEntity.position = position
        anchorPlane.addChild(boxEntity)
        
        return boxEntity
    }
}

