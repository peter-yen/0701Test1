//
//  AppDelegate.swift
//  Map
//
//  Created by 嚴啟睿 on 2020/7/3.
//  Copyright © 2020 嚴啟睿. All rights reserved.
//
// cmd + shift + Kk
import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate{

    var window: UIWindow?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        print("Error: \(error)")
        // ...
        return
      }
    
        
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
      print("Credential: \(credential)")
        Auth.auth().signIn(with: credential) { (authDataResult, error) in
            if let error = error {
            print("error: \(error)")
            }
            print("authDataResult: \(authDataResult)")
            print("user: \(authDataResult?.user)")
            print("email: \(authDataResult?.user.email)")
            
            
        }
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        var vc: UIViewController?
        let tabvc = TabBarViewController()
        vc = tabvc
//        if let user = Auth.auth().currentUser {
//            let tabbarVC = TabBarViewController()
//            vc = tabbarVC
//
//        }else {
//            let authVC = AuthViewController()
//       vc =  UINavigationController(rootViewController: authVC)
//        }
        
        window?.rootViewController = vc
        return true
            }
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    

}
