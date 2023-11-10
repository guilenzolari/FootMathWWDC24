//
//  SwiftUIView.swift
//
//
//  Created by Guilherme Ferreira Lenzolari on 17/05/23.
//

import SwiftUI
import SwiftUI


//
struct Scoreboard: View{

    var positionY: CGFloat = 135
    var positionX = [77, 123, 171, 217, 265]

    var body: some View{

        ZStack {
            Image("scoreboardBack")
                .position(x: 170, y:positionY)

            HStack(spacing: 18){
                let results = results()
                ForEach(results.indices, id: \.self){index in
                    if(results[index] == 1){
                        Image("GreenSignal")
                    } else if(results[index] == 0){
                        Image("RedSignal")
                    } else {
                        Image("GraySignal")
                    }
                }
            }.position(x:171, y: positionY)
        }
    }


    func results() -> [Int] {
        var result:[Int] = []
        for _ in 0..<5 {
            result.append(2)
        }
        for scoreIndex in winOrLose.indices {
            result[scoreIndex] = winOrLose[scoreIndex]
        }
        return result
    }
}
