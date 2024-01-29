import SwiftUI
import RealityKit
import ARKit
import UIKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var palpites: [Int]
    let scaleGoal: SIMD3<Float> = [2.4, 2.0, 2.0]
    let scaleBall: SIMD3<Float> = [2.0, 2.0, 2.0]
    
    let numbersPosition = [[-0.24, 0.23, -0.25], [-0.05, 0.23, -0.25], [0.14, 0.23, -0.25],
                           [-0.24, 0.05, -0.25], [-0.05, 0.05, -0.25], [0.14, 0.05, -0.25]]
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Bola
        let ballEntity = try! ModelEntity.load(named: "ball.usdc")
        ballEntity.scale = [0.02, 0.02, 0.02]
        let anchorBall = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
        anchorBall.addChild(ballEntity)
        anchorBall.position = [0, -0.01, 0.5]
        anchorBall.scale = scaleBall
        arView.scene.addAnchor(anchorBall)
        
        // Trave
        let goalEntity = try! ModelEntity.load(named: "gol.usdc")
        goalEntity.scale = [0.05, 0.05, 0.05]
        let anchorGoal = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
        anchorGoal.addChild(goalEntity)
        anchorGoal.scale = scaleGoal
        anchorGoal.position = [0, 0, -0.25]
        arView.scene.addAnchor(anchorGoal)
        
        // Botões e palpites
        var buttonsArrayEntity: [Entity] = []
        
        for index in 0...5 {
            let buttonsEntity = try! ModelEntity.load(named: "botaoGol\(index + 1)")
            buttonsArrayEntity.append(buttonsEntity)
            let anchorButtons = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
            anchorButtons.name = "Buttons"
            buttonsArrayEntity[index].scale = [0.05, 0.05, 0.05]
            buttonsArrayEntity[index].generateCollisionShapes(recursive: true)
            anchorButtons.addChild(buttonsArrayEntity[index])
            anchorButtons.position = [0, 0, -0.2]
            anchorButtons.scale = scaleGoal
            arView.scene.addAnchor(anchorButtons)
            
            let textMesh = MeshResource.generateText("\(palpites[index])", extrusionDepth: 0.1, font: .systemFont(ofSize: 2))
            let textMaterial = SimpleMaterial(color: .black, isMetallic: true)
            let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
            let anchorPalpiteText = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
            textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
            textEntity.generateCollisionShapes(recursive: true)
            textEntity.name = "\(index)"
            anchorPalpiteText.name = "Palpite-\(index)"
            anchorPalpiteText.addChild(textEntity)
            anchorPalpiteText.position = SIMD3<Float>(x: Float(numbersPosition[index][0]), y: Float(numbersPosition[index][1]), z: Float(numbersPosition[index][2]))
            arView.scene.addAnchor(anchorPalpiteText)
        }
        
        // Adicionar a entidade à cena
        return arView
    }
    
    //from SWiftUI to UIKit
    func updateUIView(_ arView: ARView, context: Context) {
        
        let anchorTextPalpites = arView.scene.anchors.filter { element in
            element.name.contains("Palpite")
        }
        
        //Recria o texto
        for anchorTextPalpite in anchorTextPalpites {
            if anchorTextPalpite.children.count > 0 {
                let child = anchorTextPalpite.children[0]
                
                if let index = Int(child.name) {
                    anchorTextPalpite.removeChild(child)
                    let textMesh = MeshResource.generateText("\(palpites[index])", extrusionDepth: 0.1, font: .systemFont(ofSize: 4))
                    
                    let textMaterial = SimpleMaterial(color: .black, isMetallic: true)
                    let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
                    _ = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
                    textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
                    textEntity.generateCollisionShapes(recursive: true)
                    textEntity.name = "\(index)"
                    anchorTextPalpite.addChild(textEntity)
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
