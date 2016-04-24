//
//  AppDelegate.m
//  MMD
//
//  Created by pencho on 16/2/16.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "PrepareDataWorker.h"


@interface AppDelegate ()

@end

@implementation AppDelegate




#pragma mark AppDelegateMethod
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //如果储存过用户名密码，重新登录一下
//    [PrepareDataWorker reLoginIfHasUserIdPassword];
    //配置 ZX
    [PrepareDataWorker configureZXSDK];
    //集成分享控件
 
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize backgroundObjectContext = _backgroundObjectContext;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "MMD.com.MMD" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MMD" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MMD.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
//子context（临时）
- (NSManagedObjectContext *)praviateObjectContext{
    NSManagedObjectContext *praviateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [praviateContext setParentContext:self.managedObjectContext];
    return praviateContext;
}
//主线程context 更新UI
- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setParentContext:self.backgroundObjectContext];
    
    return _managedObjectContext;
}
//父context 用于最终的更新
- (NSManagedObjectContext *)backgroundObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_backgroundObjectContext != nil) {
        return _backgroundObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _backgroundObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_backgroundObjectContext setPersistentStoreCoordinator:coordinator];
    return _backgroundObjectContext;
}

#pragma mark - Core Data Saving support
- (void)backgroundSaveContext{
    //不确定
    [self saveContext];
    
    NSManagedObjectContext *managedObjectContext = self.backgroundObjectContext;
    
    if (managedObjectContext) {
        
        [managedObjectContext performBlock:^{
            
            if ([managedObjectContext hasChanges]) {
                
                NSError *error = nil;
                
                if ([managedObjectContext save:&error]) {
                    
                    NSLog(@"_parentContext SAVED changes to persistent store");
                }else{
                    NSLog(@"_parentContext FAILED to save: %@", error);
                }
            }else{
                NSLog(@"_parentContext SKIPPED saving as there are no changes");
            }
        }];
    }
}
- (void)saveContext {
    
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        
        [managedObjectContext performBlock:^{
            NSError *error = nil;
            if ([managedObjectContext hasChanges] &&
                ![managedObjectContext save:&error]) {
                // Replace this implementation with code to handle the error
                // appropriately.
                // abort() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it
                // may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }else{
                
            }
            
        }];
    }

}

@end
