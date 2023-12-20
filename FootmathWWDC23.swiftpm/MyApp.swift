import SwiftUI
import CoreText

@main
struct MyApp: App {
    
    init() {
        if let fontURL = Bundle.main.url(forResource: "8-bit Arcade In", withExtension: "ttf") {
            do {
                CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
                print("Font loaded successfully")
            }
        } else {
            print("Font resource not found")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView  {
                Menu()
            }
            .navigationViewStyle(.stack)
            .environmentObject(AudioPlayer())
        }
    }
}

