import SwiftUI

struct AvisoDeteccaoPlanoHUD: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundStyle(.ultraThinMaterial)
                .frame(width: 310, height: 80)
            
            Text("Find a wide, unobstructed and horizontal surface. Press PLAY after the goal appears.")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .padding(.horizontal, 40)
        }
    }
}
