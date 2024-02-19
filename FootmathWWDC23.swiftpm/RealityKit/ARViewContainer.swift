import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var palpites: [Int]
    weak var timer: TimerController?
    weak var gameplayViewModel: GameplayViewModel?
    
    @EnvironmentObject var audioPlayer: AudioPlayer
    @EnvironmentObject var gameController: GameController
    
    let boxMaterial = SimpleMaterial(color: .blue, isMetallic: false)
    let textMaterial = SimpleMaterial(color: .white, isMetallic: false)
    let anchorPlane = AnchorEntity(.plane(.horizontal, classification: [.floor], minimumBounds: [0.2, 0.2]))
    let anchorScaleGoal: SIMD3<Float> = [2.4, 2.0, 2.0]
    let ballEntityScale: SIMD3<Float> = [0.04, 0.04, 0.04]
    let anchorScaleBall: SIMD3<Float> = [2.0, 2.0, 2.0]
    let goalEntityScale: SIMD3<Float> = [0.03, 0.021, 0.022]
    let goalPosition: SIMD3<Float> = [0, 0, -0.9]
    let boxPosition: [SIMD3<Float>] = [[-0.4, 0.2, -0.88],
                                       [0, 0.2, -0.88],
                                       [0.4, 0.2, -0.88],
                                       [-0.4, -0.2, -0.88],
                                       [0, -0.2, -0.88],
                                       [0.4, -0.2, -0.88]]
    var ballPosition: SIMD3<Float> = [0, -0.01, 0.5]
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        context.coordinator.addCoaching(view:arView)
        
//        arView.debugOptions = [.showPhysics, .showAnchorGeometry, .showFeaturePoints]
        
        anchorPlane.name = "AnchorPlane"
        
        // Bola
        let ballEntity = makeObject(arView: arView,
                                    name: "ball.usdc",
                                    entityScale: ballEntityScale,
                                    anchorScale: anchorScaleBall,
                                    position: ballPosition)

        let invisibleBallEntity = makeObject(arView: arView,
                                    name: "ball.usdc",
                                    entityScale: [0.001, 0.001, 0.001],
                                    anchorScale: anchorScaleBall,
                                             position: ballPosition)

        // Trave
        _ = makeObject(arView: arView,
                       name: "goalSoccer.usdc",
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
                
        context.coordinator.onTapAction(objectToMove: ballEntity, arView: arView, invisibleObject: invisibleBallEntity)
        
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
    
    func makeObject(arView: ARView, name: String, entityScale: SIMD3<Float>, anchorScale: SIMD3<Float>, position: SIMD3<Float>) -> Entity {
        let entity = try! ModelEntity.load(named: name)
        let anchor = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0,0]))
        entity.scale = entityScale
        let radians = 90.0 * Float.pi / 180.0
        entity.transform.rotation *= simd_quatf(angle: radians, axis: SIMD3<Float>(0,0,1))
        anchor.addChild(entity)
        anchor.position = position
        anchor.scale = anchorScale
        arView.scene.addAnchor(anchor)
        
        return entity
    }
    
    func makeText(arView: ARView, text: String, index: Int, textMaterial: SimpleMaterial, dadEntity: Entity){
        let textMesh = MeshResource.generateText(text, extrusionDepth: 0.1, font: .systemFont(ofSize: 5), alignment: .center)
        let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
        textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
        textEntity.position = [-0.06, -0.06, 0.01]
        textEntity.name = "Text \(index)"
        dadEntity.addChild(textEntity)
    }
    
    func makeBox(arView: ARView, name: String, position: SIMD3<Float>) -> Entity{
        let box = MeshResource.generateBox(width: 0.32, height: 0.3, depth: 0.01)
        let boxEntity = ModelEntity(mesh: box, materials: [boxMaterial])
        boxEntity.name = name
        boxEntity.position = position
        boxEntity.generateCollisionShapes(recursive: true)
        
        anchorPlane.addChild(boxEntity)
        
        return boxEntity
    }
}

