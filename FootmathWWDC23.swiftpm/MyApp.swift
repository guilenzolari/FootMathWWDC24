import SwiftUI
import CoreText

@main
struct MyApp: App {
    
    @StateObject var gameController = GameController()
    @StateObject var audioPlayer = AudioPlayer()
    
    init() {
        if let fontURL = Bundle.main.url(forResource: "8-bit Arcade In", withExtension: "ttf") {
            do {
                CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
                print("Font 8-bit Arcade In loaded successfully")
            }
        } else {
            print("Font 8-bit Arcade In not found")
        }
        if let fontURL = Bundle.main.url(forResource: "Minecraftia-Regular", withExtension: "ttf") {
            do {
                CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
                print("Font Minecraftia-Regular successfully")
            }
        } else {
            print("Font Minecraftia-Regular not found")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView  {
                MenuView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(audioPlayer)
            .environmentObject(gameController)

        }
    }
}

