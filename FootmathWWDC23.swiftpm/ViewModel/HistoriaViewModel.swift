import Foundation
import SwiftUI

class HistoriaViewModel: ObservableObject {
    
    @Published var etapaAtual = 0
    @Published var currentImageIndex = 0
    
    @Published var background = [["Storyboard 1"], ["Historia2.0", "Historia2.1", "Historia2.2", "Historia2.3"], ["Storyboard 3"], ["História4.0", "História4.1"], ["Storyboard 5"]]
    @Published var sounds = ["", "soccer-stadium", "goal-scream", "chalk-black-board", "rocket-sound"]
    @Published var button = ["next verde", "next azul", "next verde", "next azul", "next verde"]


    
    func startImageChangeTimer(intervalInSeconds: TimeInterval) {
        _ = Timer.scheduledTimer(withTimeInterval: intervalInSeconds, repeats: true) { timer in
            if self.currentImageIndex < self.background[self.etapaAtual].count - 1 {
                self.currentImageIndex += 1
            } else {
                self.currentImageIndex = 0
            }
        }
    }
    
    func avancar() -> Bool{
        if etapaAtual < background.count - 1{
            etapaAtual += 1
            return true
        } else {
            return false
        }
    }
}

