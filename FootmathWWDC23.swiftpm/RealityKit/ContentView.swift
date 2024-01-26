import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @StateObject var gameplayViewModel = GameplayViewModel()
    @StateObject var timerController = TimerController()

    let numbersPosition = [[-0.09, 0.1, -0.25], [-0.01, 0.1, -0.25], [0.07, 0.1, -0.25],
                           [-0.09, 0, -0.25], [-0.01, 0, -0.25], [0.07, 0, -0.25]]
    
    func makeUIView(context: Context) -> ARView {

        let arView = ARView(frame: .zero)
        
        // Bola
        let ballEntity = try! ModelEntity.load(named: "ball.usdc")
        ballEntity.scale = [0.02, 0.02, 0.02]
        let anchorBall = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
        anchorBall.addChild(ballEntity)
        anchorBall.position = [0, 0, 0.2]
        arView.scene.addAnchor(anchorBall)
        
        // Trave
        let goalEntity = try! ModelEntity.load(named: "gol.usdc")
        goalEntity.scale = [0.05, 0.05, 0.05]
        let anchorGoal = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
        anchorGoal.addChild(goalEntity)
        anchorGoal.position = [0, 0, -0.2]
        arView.scene.addAnchor(anchorGoal)
        
        // Botões e palpites
        var buttonsArrayEntity: [Entity] = []
        
        for index in 0...5 {
            let buttonsEntity = try! ModelEntity.load(named: "botaoGol\(index + 1)")
            buttonsArrayEntity.append(buttonsEntity)
            let anchorButtons = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
            buttonsArrayEntity[index].scale = [0.05, 0.05, 0.05]
            buttonsArrayEntity[index].generateCollisionShapes(recursive: true)
            anchorButtons.addChild(buttonsArrayEntity[index])
            anchorButtons.position = [0, 0, -0.2]
            arView.scene.addAnchor(anchorButtons)
            
            let textMesh = MeshResource.generateText("\(gameplayViewModel.palpites[index])", extrusionDepth: 0.1, font: .systemFont(ofSize: 2))
            let textMaterial = SimpleMaterial(color: .black, isMetallic: true)
            let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
            let anchorPalpiteText = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
            textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
            textEntity.generateCollisionShapes(recursive: true)
            anchorPalpiteText.addChild(textEntity)
            anchorPalpiteText.position = SIMD3<Float>(x: Float(numbersPosition[index][0]), y: Float(numbersPosition[index][1]), z: Float(numbersPosition[index][2]))
            arView.scene.addAnchor(anchorPalpiteText)
        }
        
        //Cronometro
        let textTimerMesh = MeshResource.generateText("40", extrusionDepth: 0.1, font: .systemFont(ofSize: 2))
        let textTimerMaterial = SimpleMaterial(color: .white, isMetallic: false)
        let textTimerEntity = ModelEntity(mesh: textTimerMesh, materials: [textTimerMaterial])
        let anchorTimerText = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
        textTimerEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
        anchorTimerText.addChild(textTimerEntity)
        anchorTimerText.position = [0.2,0.4,-0.25]
        arView.scene.addAnchor(anchorTimerText)
        
        //fundo placar
        let fundoContaMesh = MeshResource.generateBox(width: 0.2, height: 0.08, depth: 0.01)
        let fundoContaMaterial = SimpleMaterial(color: .white, isMetallic: false)
        let fundoContaEntity = ModelEntity(mesh: fundoContaMesh, materials: [fundoContaMaterial])
        let anchorFundoConta = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
        anchorFundoConta.addChild(fundoContaEntity)
        anchorFundoConta.position = [-0.01,0.28,-0.26]
        arView.scene.addAnchor(anchorFundoConta)
        
        //conta
        let textContaMesh = MeshResource.generateText("10 - 3", extrusionDepth: 0.1, font: .systemFont(ofSize: 2))
        let textContaMaterial = SimpleMaterial(color: .red, isMetallic: false)
        let textContaEntity = ModelEntity(mesh: textContaMesh, materials: [textContaMaterial])
        let anchorContaText = AnchorEntity(.plane(.horizontal, classification: [.floor, .table], minimumBounds: [0.2, 0.2]))
        textContaEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
        anchorContaText.addChild(textContaEntity)
        anchorContaText.position = [-0.1,0.25,-0.25]
        arView.scene.addAnchor(anchorContaText)
    
        // Adicionar a entidade à cena
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
