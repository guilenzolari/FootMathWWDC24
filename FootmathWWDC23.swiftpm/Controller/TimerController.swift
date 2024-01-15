import SwiftUI
import Combine

class TimerController: ObservableObject {
    @Published var tempo: Int = 60
    @Published var navigationLinkAtivo = false
    private var timer: Timer?
    private var cancellable: AnyCancellable?
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var gameController:GameController

    init() {
        startTimer()
    }

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

        // Utilize Combine para refletir as mudanças no contador
        cancellable = $tempo
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
        navigationLinkAtivo = true
    }
}

