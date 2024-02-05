import SwiftUI
import Combine

class TimerController: ObservableObject {
    var tempoTotalTimer = 40
    @Published var tempo: Int = 0
    @Published var navigationLinkAtivo = false
    @Published var timerIsOver = false
    private var timer: Timer?
    private var cancellable: AnyCancellable?
    private var timerIsOverCancellable: AnyCancellable?
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var gameController:GameController

    deinit {
        stopTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.tempo > 0 {
                self.tempo -= 1
            } else {
                self.stopTimer()
            }
        }
        
        tempo = tempoTotalTimer
        timerIsOver = false

        // Utilize Combine para refletir as mudanças no contador
        cancellable = $tempo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard self != nil else { return }
                // Faça algo quando o contador mudar, se necessário
            }
        
        timerIsOverCancellable = $timerIsOver
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard self != nil else { return }
                // Faça algo quando o contador mudar, se necessário
            }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
        cancellable?.cancel()
        cancellable = nil
        timerIsOver = true
        timerIsOverCancellable?.cancel()
        timerIsOverCancellable = nil
    }
}

