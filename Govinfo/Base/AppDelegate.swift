//
//  AppDelegate.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit
import CoreData
import FirebaseCore
import GoogleSignIn
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let viewController = SplashRouter()
        let navigation = UINavigationController(rootViewController: viewController.start())
        
        setNavBarStyle(navigation: navigation)

        
        viewController.setNavigation(navigation)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    private func setNavBarStyle(navigation: UINavigationController) {
        navigation.setNavigationBarHidden(true, animated: false)
        navigation.navigationBar.tintColor = .govinfoBlack
        
        if #available(iOS 13, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.govinfoBlack ?? UIColor.black,
                NSAttributedString.Key.font: UIFont.getComicFont(16) ?? .boldSystemFont(ofSize: 16)]
            
            navigationBarAppearance.shadowColor = .clear
            navigationBarAppearance.backgroundColor = .govinfoOrangeStrong
            
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .govinfoOrangeStrong
            
            if #available(iOS 15, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
        } else {
            navigation.navigationBar.barTintColor = .govinfoOrangeStrong
            navigation.navigationBar.backgroundColor = .govinfoOrangeStrong
            navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.govinfoBlack ?? UIColor.black]
        }
    }
}

