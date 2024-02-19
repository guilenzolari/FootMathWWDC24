import Foundation
import SwiftUI

class PlanetasViewModel: ObservableObject {
    
    @Published var currentImageIndex = 0
    @EnvironmentObject var gameController:GameController
    
    var timer:Timer?
    
    
    let images = [["animacao1Foguete0", "animacao1Foguete1", "animacao1Foguete2", "animacao1Foguete3", "animacao1Foguete4", "animacao1Foguete5", "animacao1Foguete6", "animacao1Foguete7"], ["animacao2Foguete0", "animacao2Foguete1", "animacao2Foguete2", "animacao2Foguete3", "animacao2Foguete4", "animacao2Foguete5", "animacao2Foguete6", "animacao2Foguete7"], ["animacao3Foguete0", "animacao3Foguete1", "animacao3Foguete2", "animacao3Foguete3", "animacao3Foguete4", "animacao3Foguete5", "animacao3Foguete6", "animacao3Foguete7", "animacao3Foguete8", "animacao3Foguete9"]]
    
    func startImageChangeTimer(intervalInSeconds: TimeInterval, fase: Int, navigation: Binding<Bool>) {
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: intervalInSeconds, repeats: true) { timer in
            
            if self.currentImageIndex < self.images[fase].count - 1 {
                self.currentImageIndex += 1
            } else {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {
                    navigation.wrappedValue = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0)  {
                    self.currentImageIndex = 0
                }
            }
        }
    }
}
