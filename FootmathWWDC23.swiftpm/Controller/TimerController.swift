import SwiftUI
import Combine

class TimerModel: ObservableObject {
    @Published var countdown: Int = 6
    private var timer: Timer?
    private var cancellable: AnyCancellable?

    init() {
        startTimer()
    }

    deinit {
        stopTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                self.stopTimer()
            }
        }

        // Utilize Combine para refletir as mudanças no contador
        cancellable = $countdown
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
    }
}

