//
//  TabViewController.swift
//  DerDieDas
//
//  Created by Şule Kaptan on 10.01.2024.
//

import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tab1 = HomeViewController()
        tab1.title = "Artikel im Deutschen"
        let modeToggleButton = UIBarButtonItem(image: UIImage(systemName: "sun.max.fill"), style: .plain, target: self, action: #selector(toggleMode))
        tab1.navigationItem.rightBarButtonItem = modeToggleButton
        

        let tab2 = BookmarksViewController()
        tab2.title = "Lesezeichen"
        tab2.navigationItem.rightBarButtonItem = modeToggleButton

        let tab3 = GameViewController()
        tab3.title = "Teste dich selbst!"
        tab3.navigationItem.rightBarButtonItem = modeToggleButton

        updateModeToggleButton()

        let nav1 = UINavigationController(rootViewController: tab1)
        let nav2 = UINavigationController(rootViewController: tab2)
        let nav3 = UINavigationController(rootViewController: tab3)

        nav1.tabBarItem = UITabBarItem(title: "Suche", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Lesezeichen", image: UIImage(systemName: "bookmark.fill"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Übung", image: UIImage(systemName: "pencil.and.outline"), tag: 3)

        // TabBar ve NavigationBar renklerini ayarlayın
        tabBar.backgroundColor = UIColor(named: "bgColor")
        tabBar.layer.shadowColor = UIColor(named: "textColor")?.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 1, height: 2)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowOpacity = 0.5

        // NavigationBar için dark mode ayarları
        if let navigationBar1 = (viewControllers?[0] as? UINavigationController)?.navigationBar {
                    setupNavigationBarColors(navigationBar1)
                }
                if let navigationBar2 = (viewControllers?[1] as? UINavigationController)?.navigationBar {
                    setupNavigationBarColors(navigationBar2)
                }
                if let navigationBar3 = (viewControllers?[2] as? UINavigationController)?.navigationBar {
                    setupNavigationBarColors(navigationBar3)
                }

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "textColor")!], for: .selected)
        UITabBar.appearance().tintColor = UIColor(named: "textColor")!

        setViewControllers([nav1, nav2, nav3], animated: true)
        hidesBottomBarWhenPushed = false
    }

    @objc private func toggleMode() {
        if #available(iOS 13.0, *) {
            let currentInterfaceStyle = traitCollection.userInterfaceStyle
            let newStyle: UIUserInterfaceStyle = (currentInterfaceStyle == .light) ? .dark : .light
            overrideUserInterfaceStyle = newStyle
            updateModeToggleButton()
        }
    }

    func updateModeToggleButton() {
        // Update the icon based on the current mode
        if #available(iOS 13.0, *) {
            let currentInterfaceStyle = traitCollection.userInterfaceStyle
            let iconName = (currentInterfaceStyle == .light) ? "sun.max.fill" : "moon.fill"
            
            // Update the icon for each tabBarItem
            if let button1 = (viewControllers?[0] as? UINavigationController)?.topViewController?.navigationItem.rightBarButtonItem {
                button1.image = UIImage(systemName: iconName)
            }
            if let button2 = (viewControllers?[1] as? UINavigationController)?.topViewController?.navigationItem.rightBarButtonItem {
                button2.image = UIImage(systemName: iconName)
            }
            if let button3 = (viewControllers?[2] as? UINavigationController)?.topViewController?.navigationItem.rightBarButtonItem {
                button3.image = UIImage(systemName: iconName)
            }
        }
    }
    
    func setupNavigationBarColors(_ navigationBar: UINavigationBar) {
            navigationBar.barTintColor = UIColor(named: "textColor")
            navigationBar.tintColor = UIColor(named: "textColor")
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textColor")!]
        }
}
