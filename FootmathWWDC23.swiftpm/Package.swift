// swift-tools-version: 5.6

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Footmath",
    platforms: [
        .iOS("15.2")
    ],
    products: [
        .iOSApplication(
            name: "Footmath",
            targets: ["AppModule"],
            bundleIdentifier: "com.gui.Footmath",
            teamIdentifier: "8JTQ9M4J69",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.green),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .portraitUpsideDown
            ],
            appCategory: .sportsGames
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .copy("8-bit Arcade In.ttf"),
                .copy("Minecraftia-Regular.ttf"),
                .copy("Resources/Sounds/click-botao.mp3"),
                .copy("Resources/Sounds/soccer-kick.mp3"),
                .copy("Resources/Sounds/latin-music.mp3"),
                .copy("Resources/Sounds/missed-goal.mp3"),
                .copy("Resources/Sounds/soccer-stadium.mp3"),
                .copy("Resources/Sounds/goal-scream.mp3"),
                .copy("Resources/Sounds/apito-futebol.mp3")
            ]
        )
    ]
)
