//
//  AppDelegate.m
//  climateConvos
//
//  Created by acn96 on 2/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "AppDelegate.h"
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Show Slashscreens
    [FIRApp configure];
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.window.rootViewController = [SB instantiateViewControllerWithIdentifier:@"launchscreen"];
    [self.window makeKeyAndVisible];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //after launch screen
        //first screen
        self.window.rootViewController = [SB instantiateViewControllerWithIdentifier:@"launchscreen2"];
        [self.window makeKeyAndVisible];
        //second screen
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.window.rootViewController = [SB instantiateViewControllerWithIdentifier:@"splashscreen"];
            [self.window makeKeyAndVisible];
            
            
            NSString *startScreen = [self checkSkip];
            
            
            
            //Enter the app
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.000000005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.window.rootViewController = [SB instantiateViewControllerWithIdentifier: startScreen];
                [self.window makeKeyAndVisible];
            });
            
        });
        
    });
    
    
    return YES;
}

-(NSString*) checkSkip
{
    NSString *theSkip = @"intro";
    
    NSLog(@"%@", theSkip);
    
    NSString *currentSavedStatus = [[NSUserDefaults standardUserDefaults]
                                    stringForKey:@"tutSkipStatus"];
    
    
    if ([currentSavedStatus isEqualToString:(@"skipToLocation")])
    {
        theSkip = @"location";
        
    } else if ([currentSavedStatus isEqualToString:(@"skipToDiscover")])
    {
        theSkip = @"discover";
    }
    else
    {
        theSkip = @"intro";
    }
    
    NSLog(@"%@", theSkip);
    
    return theSkip;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
