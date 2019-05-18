//
//  AppDelegate.swift
//  Todoey
//
//  Created by Bogi Eliasen on 4/10/19.
//  Copyright © 2019 Bogi Eliasen. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    do{
      _ = try Realm()
    }
    catch{
      print("Tried initializing realm, \(error)")
    }
    
    return true
  }

  

  


}

