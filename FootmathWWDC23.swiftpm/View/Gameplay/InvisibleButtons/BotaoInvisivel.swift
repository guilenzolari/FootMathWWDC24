//Rectangle Map
// 1 | 2 | 3
// 4 | 5 | 6

import Foundation
import SwiftUI

//screen 1
struct BotaoInvisivel: View {
    
    var posicaoDoRetanguloInvisivel:[(x:CGFloat,y:CGFloat)]
    var tamanhoDoRetanguloInvisivel:(width:CGFloat, height:CGFloat)

    @State private var isActive = false
    @State private var posicaoDaBola = CGPoint(x: 412, y: 1100)
    @State private var tapped = false
    @State private var nextScreenTime = 1.0
    @EnvironmentObject var data: Jogo
    @Binding var isRunning:Bool
    let jogadas = Jogo()
    
    var body: some View {
        ZStack{
            
            //Retangulo invisivel
            ForEach(0..<6, id: \.self){index in
                Rectangle()
                    .frame(width: tamanhoDoRetanguloInvisivel.width, height: tamanhoDoRetanguloInvisivel.height)
                    .position(x: posicaoDoRetanguloInvisivel[index].x, y: posicaoDoRetanguloInvisivel[index].y)
                    .onTapGesture {
                        if !tapped{

                            jogadas.avaliarJogada(indicePalpite: index)
                            
                            //timer to go to the next screen
                            Timer.scheduledTimer(withTimeInterval: nextScreenTime, repeats: false) { timer in
                                isRunning = false
                                isActive = true
                            }
                            
                            //ball animation
                            withAnimation{
                                self.posicaoDaBola = CGPoint(x: posicaoDoRetanguloInvisivel[index].0, y: posicaoDoRetanguloInvisivel[index].1)
                            }
                        }
                       // print(data.jogadas[0])
                        tapped = true
                    }
            }.opacity(0.1)
                .foregroundColor(colorPink)
            
            //Ball image
            Image("ball")
                .position(posicaoDaBola)
            
            if isActive{
                Gameplay2()
            }
            
        }
        
    }
}

