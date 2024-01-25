//
//  ContentView.swift
//  ARintrodution
//
//  Created by Guilherme Ferreira Lenzolari on 16/01/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
    }
}

struct ARViewContainer: UIViewRepresentable {
    let numbers = ["1", "2", "3", "4", "5", "6"]
    let numbersPosition = [[-0.09, 0.1, -0.25], [-0.01, 0.1, -0.25], [0.07, 0.1, -0.25],
                           [-0.09, 0, -0.25], [-0.01, 0, -0.25], [0.07, 0, -0.25]]
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Bola
        let ballEntity = try! ModelEntity.load(named: "ball.usdc")
        ballEntity.scale = [0.02, 0.02, 0.02]
        
        let anchorBall = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: [0.2, 0.2]))
        anchorBall.addChild(ballEntity)
        anchorBall.position = [0, 0, 0.2]
        arView.scene.addAnchor(anchorBall)
        
        // Trave
        let goalEntity = try! ModelEntity.load(named: "gol.usdc")
        goalEntity.scale = [0.05, 0.05, 0.05]

        let anchorGoal = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: [0.2, 0.2]))
        
        anchorGoal.addChild(goalEntity)
        anchorGoal.position = [0, 0, -0.2]
        arView.scene.addAnchor(anchorGoal)
        
        
        // Botões e texto
        var buttonsArrayEntity: [Entity] = []
        
        for index in 0...5 {
            let buttonsEntity = try! ModelEntity.load(named: "botaoGol\(index + 1)")
            buttonsArrayEntity.append(buttonsEntity)
            
            let anchorButtons = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: [0.2, 0.2]))
            
            buttonsArrayEntity[index].scale = [0.05, 0.05, 0.05]
            buttonsArrayEntity[index].generateCollisionShapes(recursive: true)
            anchorButtons.addChild(buttonsArrayEntity[index])
            anchorButtons.position = [0, 0, -0.2]
            arView.scene.addAnchor(anchorButtons)
            
            let textMesh = MeshResource.generateText(numbers[index], extrusionDepth: 0.1, font: .systemFont(ofSize: 2))
            let textMaterial = SimpleMaterial(color: .black, isMetallic: true)
            let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
            let anchorText = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: [0.2, 0.2]))
            textEntity.name = "ButtonAnchor"
            textEntity.scale = SIMD3<Float>(x: 0.03, y: 0.03, z: 0.1)
            textEntity.generateCollisionShapes(recursive: true)
            anchorText.addChild(textEntity)
            anchorText.position = SIMD3<Float>(x: Float(numbersPosition[index][0]), y: Float(numbersPosition[index][1]), z: Float(numbersPosition[index][2]))
            
            arView.scene.addAnchor(anchorText)
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
