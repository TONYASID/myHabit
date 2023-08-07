//
//  TabBarController.swift
//  MyHabits
//
//  Created by Anton Kislov on 05.06.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setupTabBar()
        view.backgroundColor = const.rgbGray
    }
    
    private func setupTabBar() { 
        let customFont = UIFont.systemFont(ofSize: 10, weight: .regular)
        let normalTextAttributes = [NSAttributedString.Key.font: customFont,
                                    NSAttributedString.Key.foregroundColor: const.sistemGray2]
        let selectedTextAttributes = [NSAttributedString.Key.font: customFont,
                                      NSAttributedString.Key.foregroundColor: const.rgbPurple]
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = normalTextAttributes
        tabBarItemAppearance.selected.titleTextAttributes = selectedTextAttributes
        tabBarItemAppearance.normal.iconColor = const.sistemGray2
        tabBarItemAppearance.selected.iconColor = const.rgbPurple
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.inlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.configureWithDefaultBackground()
        
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.standardAppearance = tabBarAppearance
        
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: HabitsViewController(),
                       title: "Привычки",
                       image: UIImage(systemName: "rectangle.split.1x2.fill")),
            generateVC(viewController: InfoViewController(),
                       title: "Информация",
                       image: UIImage(systemName: "info.circle"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}

