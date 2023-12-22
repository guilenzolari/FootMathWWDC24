//TO DO
//Fazer a bolo diminuir de tamanho conforme se move
//fazer goleiro
//colocar sons de quando faz gol e erra

import SwiftUI

struct GameplayView: View {
    @StateObject var timerModel = TimerModel()
    @State var posicaoBola = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height * 7 / 8)
    var gameController = GameController()
    let linhas = [
        GridItem(.fixed(3), spacing: 60),
        GridItem(.fixed(3))]

    init() {
        gameController.iniciarJogada()
    }

    var body: some View {
        ZStack {
            Image("GameplayBackgound")
                .edgesIgnoringSafeArea(.top)

            Text("\(timerModel.countdown)")
                .foregroundColor(.white)
                .padding(.bottom, 640)
                .padding(.leading, 250)

            Text("\(gameController.numero1) + \(gameController.numero2)")
                .foregroundColor(.white)
                .padding(.bottom, 405)
            
            VStack{
                LazyHGrid(rows: linhas, spacing: 60,content: {
                    ForEach(0..<gameController.palpites.count, id: \.self) { index in
                        Text("\(gameController.palpites[index])")
                            .onTapGesture {
                                if(index == gameController.palpiteCorreto){
                                    gameController.adicionarResultado(ResultadoJogada.acertou)
                                    posicaoBola = CGPoint(x: 400, y: 300)
                                } else{
                                    gameController.adicionarResultado(ResultadoJogada.errou)
                                    posicaoBola = CGPoint(x: 100, y: 300)
                                }
                            }
                    }
                })
            }.padding(.bottom, 35)
            .foregroundColor(.black)

            Image("ball")
                .position(posicaoBola)
            
        }.font(Font.custom("8-bit Arcade In", size: 60))
        .navigationBarBackButtonHidden(true)
    }
}

