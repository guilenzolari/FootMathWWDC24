import SwiftUI
import RealityKit
import ARKit
import UIKit

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var palpites: [Int]
    let boxMaterial = SimpleMaterial(color: .lightGray, isMetallic: false)
    let textMaterial = SimpleMaterial(color: .black, isMetallic: false)
    let anchorPlane = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
    
    let anchorScaleGoal: SIMD3<Float> = [2.4, 2.0, 2.0]
    let ballEntityScale:SIMD3<Float> = [0.02, 0.02, 0.02]
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
        arView.addCoaching()
        arView.debugOptions = [.showPhysics, .showAnchorGeometry, .showFeaturePoints]
        
        anchorPlane.name = "AnchorPlane"
        
        // Bola
        makeObject(arView: arView, name: "ball.usdc", entityScale: ballEntityScale, anchorScale: anchorScaleBall, position: ballPosition)
        
        // Trave
        makeObject(arView: arView, name: "gol.usdc", entityScale: goalEntityScale, anchorScale: anchorScaleGoal, position: goalPosition)
        
        arView.scene.addAnchor(anchorPlane)
        
        for index in 0...5 {
            
            // Botões
            let boxEntity = makeBox(arView: arView, name: "Slot \(index)", position: boxPosition[index])
                   
            //Textos
            makeText(arView: arView, text: "\(palpites[index])", index: index , textMaterial: textMaterial, dadEntity: boxEntity)
        }
        
        arView.onTapAction()
        
        return arView
    }

    //from SWiftUI to UIKit
    func updateUIView(_ arView: ARView, context: Context) {
        
        let anchorSlots = arView.scene.anchors.filter { element in
            return element.name.contains("AnchorPlane")
        }
        
        let slots = anchorSlots.first?.children.filter { element in
            return element.name.contains("Slot")
        }
        
        if let slots {
            
            for slot in slots {
        
                let texts = slot.children.filter { element in
                    element.name.contains("Text")
                }
                
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

        //from UIKit to SwifUi
        func makeCoordinator() -> Coordinator {
            return Coordinator(palpites: $palpites)
        }
        
        class Coordinator: NSObject{
            @Binding var palpites: [Int]
            
            init(palpites: Binding<[Int]>){
                self._palpites = palpites
            }
        }
    }
    
    func makeObject(arView: ARView, name: String, entityScale: SIMD3<Float>, anchorScale: SIMD3<Float>, position: SIMD3<Float>){
        let entity = try! ModelEntity.load(named: name)
        let anchor = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0,0]))
        entity.scale = entityScale
        anchor.addChild(entity)
        anchor.position = position
        anchor.scale = anchorScale
        arView.scene.addAnchor(anchor)
    }
    
    func makeText(arView: ARView, text: String, index: Int, textMaterial: SimpleMaterial, dadEntity: Entity){
        let textMesh = MeshResource.generateText(text, extrusionDepth: 0.1, font: .systemFont(ofSize: 3.5), alignment: .center)
        let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
        textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
        textEntity.position = [-0.05, -0.06, 0.01]
        textEntity.generateCollisionShapes(recursive: true)
        textEntity.name = "Text \(index)"
        dadEntity.addChild(textEntity)
    }
    
    func makeBox(arView: ARView, name: String, position: SIMD3<Float>) -> Entity{
        let box = MeshResource.generateBox(width: 0.16, height: 0.15, depth: 0.01)
        let boxEntity = ModelEntity(mesh: box, materials: [boxMaterial])
        boxEntity.name = name
        boxEntity.position = position
        anchorPlane.addChild(boxEntity)
        
        return boxEntity
        
    }
}
