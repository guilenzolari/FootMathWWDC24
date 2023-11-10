//
//  Gameplay.swift
//  Footmath
//
//  Created by Guilherme Ferreira Lenzolari on 08/04/23.
//

import Foundation
import SwiftUI

struct Gameplay: View{
    
    let posicaoOpcoesDeResultado: [(x: CGFloat, y: CGFloat)] = [(x: 210, y: 525), (x: 417, y: 525), (x: 624, y: 525), (x: 210, y: 655), (x: 417, y: 655), (x: 624, y: 655)]

    let tamanhoDoRetanguloInvisivel: (CGFloat, CGFloat) = (
        185, 100
    )
    
    let posicaoDoRetanguloInvisivel: [(x: CGFloat, y: CGFloat)] = [
        (x:210, y: 535),
        (x:417, y: 535),
        (x:624, y: 535),
        (x:210, y: 665),
        (x:417, y: 665),
        (x:624, y: 665)
    ]
    
    @State var timerRunning = true
    @State var countDownTimer = 15
    @EnvironmentObject var data: Jogo
    let jogadas = Jogo()
    
    var body: some View{
        if timerRunning{
            
            ZStack{
                
                Image("GameplayBackgound")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.top)
                
                Scoreboard()
                
                Group{
                    
                    //texto da operação
                    Text(operation1)
                        .foregroundColor(.white)
                        .position(x:417, y: 265)
                    
                    //texto das opcoes de resultado
                    ForEach(0..<6, id:\.self){ index in
                        Text("\(jogadas.jogadaAtual.opcoes[index])")
                            .position(x:posicaoOpcoesDeResultado[index].x, y:posicaoOpcoesDeResultado[index].y)
                    }
                    
                }.font(Font.custom("8-bit Arcade In", size:120))
                
                //timer
                        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                        Text("\(countDownTimer)")
                          .onReceive(timer){_ in
                            if countDownTimer > 0 && timerRunning {
                                countDownTimer -= 1
                            }else{
                                if timerRunning {
                                    timerRunning = false
                                    Lose()
                                    data.vazio()
                                }
                            }
                          }.font(Font.custom("8-bit Arcade In", size:140))
                          .position(x:722, y: 118)
                          .foregroundColor(.white)
                
                //Botões de click
                BotaoInvisivel(posicaoDoRetanguloInvisivel: posicaoDoRetanguloInvisivel, tamanhoDoRetanguloInvisivel: tamanhoDoRetanguloInvisivel,
                               isRunning: $timerRunning)
            }
            .navigationBarBackButtonHidden(true)

        } else {
            VStack {
                Gameplay2()
            }
        }
    }
}
