import Foundation
import SwiftUI

class VitoriaFasesModel: ObservableObject {
    @Published var currentImageIndex = 0
    let images = ["VitoriaBackground0", "VitoriaBackground1"]
    
    func startImageChangeTimer(intervalInSeconds: TimeInterval) {
        _ = Timer.scheduledTimer(withTimeInterval: intervalInSeconds, repeats: true) { timer in
            if self.currentImageIndex < self.images.count - 1 {
                self.currentImageIndex += 1
            } else {
                self.currentImageIndex = 0
            }
        }
    }
}
    

