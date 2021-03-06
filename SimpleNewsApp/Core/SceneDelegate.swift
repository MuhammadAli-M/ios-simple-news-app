//
//  SceneDelegate.swift
//  SimpleNewsApp
//
//  Created by Muhammad Adam on 12/8/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = getInitialVC()
        window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
    // MARK:- Methods
    func getInitialVC() -> UIViewController{
        let firstTime = Caching.shared().objectForKey(key: .firstLanuch) as? Bool ?? true
        Caching.shared().setKey(key: .firstLanuch, value: false)
        let storyboard = UIStoryboard(name: StoryboardName.Main.rawValue, bundle: nil)
        
        let vc: UIViewController
        if firstTime{
            vc = storyboard.instantiateViewController (withIdentifier: OnBoardingVC.storyboardId)
        }else{
            vc = storyboard.instantiateViewController (withIdentifier: HeadlinesVC.storyboardId)
            if let headlinesVC = vc as? HeadlinesVC{
                if let country = Caching.shared().objectForKey(key: .selectedCountry) as? CountryName,
                   let categories = Caching.shared().objectForKey(key: .selectedCategories) as? [CategoryName] {
                    headlinesVC.country = country
                    headlinesVC.categories = categories
                }
            }
            
        }
        return UINavigationController(rootViewController: vc)
    }

}

