import Foundation
import SwiftUI

class MenuViewModel: ObservableObject {
    @Published var currentImageIndex = 0
    let images = ["Menu inicial0", "Menu inicial1", "Menu inicial2"]
    
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
    
