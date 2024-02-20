import SwiftUI

struct AvisoDeteccaoPlanoHUD: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundStyle(.ultraThinMaterial)
                .frame(width: 310, height: 55)
            
            Text("Find a wide, unobstructed surface")
                .foregroundColor(.white)
                .font(.system(size: 20))
        }
    }
}
