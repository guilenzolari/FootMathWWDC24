import SwiftUI

@main
struct MyApp: App {
    @StateObject var gameController = GameController()
    @StateObject var audioPlayer = AudioPlayer()
    @StateObject var timerController = TimerController()
    
    init() {
        if let fontURL = Bundle.main.url(forResource: "8-bit Arcade In", withExtension: "ttf") {
            do {
                CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
                print("Font 8-bit Arcade In loaded successfully")
            }
        } else {
            print("Font 8-bit Arcade In not found")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView  {
                VitoriaFasesView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(audioPlayer)
            .environmentObject(gameController)
            .environmentObject(timerController)

        }
    }
}

