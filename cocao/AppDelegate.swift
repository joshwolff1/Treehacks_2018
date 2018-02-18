//
//  AppDelegate.swift
//  cocao
//
//  Created by Josh Wolff on 2/17/18.
//  Copyright © 2018 jw1. All rights reserved.
//

import UIKit
import HoundifySDK
import AWSCore

// test test 2018

// This actually needs to be here.
let userPoolID = "SampleUserPool"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cognitoConfig:CognitoConfig?
    
    // set up the initialized flag
    // FROM AWS SDK INSTALLATION INSTRUCTIONS
    var isInitialized: Bool = false
    // var pinpoint: AWSPinpoint?
    
    // FROM AWS SDK INSTALLATION INSTRUCTIONS & SIGN IN INSTRUCTIONS
    func application(_ application: UIApplication, open url: URL,
                     sourceApplication: String?, annotation: Any) -> Bool {
        
        AWSDDLog.sharedInstance.logLevel = .verbose
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        
        // set up Cognito config
        self.cognitoConfig = CognitoConfig()
        // set up Cognito
        setupCognitoUserPool()
        
        return true
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Hound.setClientID("ewb8Zfanqv_n2FmfW5bObA==")
        Hound.setClientKey("gsqdIB8K6qMLx3dNNW9rKTnxPZc9YE4HIVGBGIcWVxjaVs78V5IJi3aJDyk3sOXZ90PXmEjDvJbccRVMNgiTnQ==")
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("didFinishLaunching:")
        
        // set up logging for AWS and Cognito
        AWSDDLog.sharedInstance.logLevel = .verbose
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        
        // set up Cognito config
        self.cognitoConfig = CognitoConfig()
        
        // set up Cognito
        setupCognitoUserPool()
        
        return true
        
    }
    
    func setupCognitoUserPool() {
        
        // we pull the needed values from the CognitoConfig object
        // this just pulls the values in from the plist
        let clientId:String = self.cognitoConfig!.getClientId()
        let poolId:String = self.cognitoConfig!.getPoolId()
        let clientSecret:String = self.cognitoConfig!.getClientSecret()
        let region:AWSRegionType = self.cognitoConfig!.getRegion()
        let identityPoolId:String = self.cognitoConfig!.getIdentityPoolId()
        
        // FOR IAM
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.USEast1, identityPoolId: identityPoolId, identityProviderManager: "" as? AWSIdentityProviderManager)
        // AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
        // AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        // we need to let Cognito know which region we plan to connect to
        let serviceConfiguration:AWSServiceConfiguration = AWSServiceConfiguration(region: region, credentialsProvider: credentialsProvider)
        
        // FOR IAM
        AWSServiceManager.default().defaultServiceConfiguration = serviceConfiguration
        
//        // we need to pass it the clientId and clientSecret from the app and the poolId for the user pool
//        let cognitoConfiguration:AWSCognitoIdentityUserPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: clientId, clientSecret: clientSecret, poolId: poolId, shouldProvideCognitoValidationData: true)
//        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: cognitoConfiguration, forKey: userPoolID)
//        let pool:AWSCognitoIdentityUserPool = AppDelegate.defaultUserPool()
//        // we need to set the AppDelegate as the user pool's delegate, which will get called when events occur
//        pool.delegate = self as AWSCognitoIdentityInteractiveAuthenticationDelegate
        
        let cognitoId = credentialsProvider.identityId
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

