//
//  SceneDelegate.swift
//  Meme Creator
//
//  Created by MACBOOK on 10/15/19.
//  Copyright © 2019 Alexander. All rights reserved.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let mainController = MainTabBarController()
            window.rootViewController = mainController
            self.window = window
            window.makeKeyAndVisible()
            print("Scene Delegate")
        }
    }
}
