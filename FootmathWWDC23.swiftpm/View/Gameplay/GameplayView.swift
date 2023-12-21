//TO DO
//Fazer a bolo diminuir de tamanho conforme se move
//fazer goleiro
//colocar sons de quando faz gol e erra

import SwiftUI

struct GameplayView: View {    
    @StateObject var timerModel = TimerModel()
    var gameController = GameController()

    init() {
        gameController.iniciarJogada()
    }

    var body: some View {
        
        ZStack{
            Image("GameplayBackgound")
                .edgesIgnoringSafeArea(.top)
        
            Text("\(timerModel.countdown)")
                .font(Font.custom("8-bit Arcade In", size: 60))
                .foregroundColor(.white)
                .padding(.bottom, 640)
                .padding(.leading, 250)
            
            Text("\(gameController.numero1) + \(gameController.numero2)")
                .font(Font.custom("8-bit Arcade In", size: 50))
                .foregroundColor(.white)
                .padding(.bottom, 405)
                        
            ChutesView(gameController: gameController)
                .padding(.bottom, 35)
            
            Image("ball")
                .padding(.top, 630)
            

        }.navigationBarBackButtonHidden(true)
    }
    
}
