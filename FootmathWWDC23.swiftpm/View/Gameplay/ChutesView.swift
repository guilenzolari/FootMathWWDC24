import SwiftUI

struct ChutesView: View {
    
    var gameController:GameController
    @Binding var posicaoBola: CGPoint
    
    let linhas = [
        GridItem(.fixed(3), spacing: 60),
        GridItem(.fixed(3)),
    ]

    init(gameController:GameController, posicaoBola: Binding<CGPoint>){
        self.gameController = gameController
        self._posicaoBola = posicaoBola
    }
        
    var body: some View {
        VStack{
            LazyHGrid(rows: linhas, spacing: 60,content: {
                ForEach(0..<gameController.palpites.count, id: \.self) { index in
                    Text("\(gameController.palpites[index])")
                        .onTapGesture {
                            if(index == gameController.palpiteCorreto){
                                gameController.adicionarResultado(ResultadoJogada.acertou)
                                posicaoBola = CGPoint(x: 300, y: 300)
                            } else{
                                gameController.adicionarResultado(ResultadoJogada.errou)
                                posicaoBola = CGPoint(x: 300, y: 300)
                            }
                        }
                }
            })
        }
        .font(Font.custom("8-bit Arcade In", size: 50))
        .foregroundColor(.black)
    }
}
