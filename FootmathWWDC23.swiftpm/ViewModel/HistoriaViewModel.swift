import Foundation
import SwiftUI

class HistoriaViewModel: ObservableObject {
    
    @Published var etapaAtual = 0
    @Published var currentImageIndex = 0
    
    let historia0 = ["Menu inicial0", "Menu inicial1", "Menu inicial2"]
    let historia1 = ["Menu inicial0", "Menu inicial1", "Menu inicial2"]
    let historia2 = ["Menu inicial0", "Menu inicial1", "Menu inicial2"]
    let historia3 = ["Menu inicial0", "Menu inicial1", "Menu inicial2"]
    let historia4 = ["Menu inicial0", "Menu inicial1", "Menu inicial2"]
    
    @Published var background = ["Storyboard 1", "Storyboard 2", "Storyboard 3", "Storyboard 4", "Storyboard 5"]
    @Published var sounds = ["space-sound", "soccer-stadium", "goal-scream", "chalk-black-board","rocket-sound"]
    @Published var button = ["next verde", "next azul", "next verde", "next azul", "next verde"]

    
    func avancar() -> Bool{
        if etapaAtual < background.count - 1{
            etapaAtual += 1
            return true
        } else {
            return false
        }
    }
}
