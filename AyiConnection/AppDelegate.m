//
//  AppDelegate.m
//  AyiConnection
//
//  Created by JCB on 2/20/17.
//  Copyright © 2017 Mobile LLC. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <RestKit/RestKit.h>
#import "RKObjectManager+EntitiesMapping.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [self setupRest];
    
   // [self getAccessToken];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
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
    [FBSDKAppEvents activateApp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)setupRest {
    
    NSURL *baseURL = [NSURL URLWithString:@"http://sandbox.ayiconnection.com"];
    
    // Set high log level
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/CoreData/Cache", RKLogLevelOff);
    
    // Setup MODEL
    
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"AyiConnection" ofType:@"momd"]];
    
    // NOTE: Due to an iOS bug, the managed object model returned is immutable.
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    
    // Setup STORE
    
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    
    // Initialize the Core Data stack
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSError *error = nil;
    
    NSDictionary * dictOption = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:NSSQLiteManualVacuumOption];
    
    [managedObjectStore addSQLitePersistentStoreAtPath:[[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:@"AyiConnection.sqlite"]
                                fromSeedDatabaseAtPath:nil
                                     withConfiguration:nil
                                               options:@{ NSSQLitePragmasOption : @{ @"journal_mode" : @"DELETE" } }
                                                 error:&error];
    
    // error setting up the file for the coredata.
    if (error)
    {
        // trying to remove the existing one, and let Coredata to create new ones.
        NSLog(@"Whoops, couldn't create store. First attempt: %@", error);
        
        // remove the sqlite files
        [self removeCoreDateFiles];
        
        error = nil;
        
        // force to dowload the filter info from the database
        
        [managedObjectStore addSQLitePersistentStoreAtPath:[[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:@"AyiConnection.sqlite"]
                                    fromSeedDatabaseAtPath:nil
                                         withConfiguration:nil
                                                   options:@{ NSSQLitePragmasOption : @{ @"journal_mode" : @"DELETE" } }
                                                     error:&error];
        
        if (error)
        {
            // error setting up the coredata file.
            NSLog(@"Whoops, couldn't create store: %@", error);
            //            initialDB_GoldenSpear.sqlite
            return;
        }
        
        //        return;
    }
    
    [managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    // Setup CACHE
    
    managedObjectStore.managedObjectCache = [[RKFetchRequestManagedObjectCache alloc] init];
    //initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    // Setup OBJECT MANAGER
    
    [RKObjectManager managerWithBaseURL:baseURL];
    
    [RKObjectManager sharedManager].managedObjectStore = managedObjectStore;
    
    //[[RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext setRetainsRegisteredObjects:YES];
    
    // Setup objects mapping
    [[RKObjectManager sharedManager] defineMappings];
}

-(void) removeCoreDateFiles
{
    [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * storePath = [[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:@"AyiConnection.sqlite"];
    
    NSLog(@"Deleting: %@", storePath);
    
    [fileManager removeItemAtPath:storePath error:NULL];
    
    // WE WILL ALWAYS REMOVE -SHM AND -WAL TO AVOID MALFORMATIONS!!!
    //if (DOWNLOAD_3_FILES)
    {
        storePath = [[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:@"AyiConnection.sqlite-shm"];
        
        NSLog(@"Deleting: %@", storePath);
        
        [fileManager removeItemAtPath:storePath error:NULL];
        
        storePath = [[[self applicationDocumentsDirectory] path] stringByAppendingPathComponent:@"AyiConnection.sqlite-wal"];
        
        NSLog(@"Deleting: %@", storePath);
        
        [fileManager removeItemAtPath:storePath error:NULL];
    }
    
    [RKObjectManager setSharedManager:nil];
    
    [RKManagedObjectStore setDefaultStore:nil];
    
}

#pragma mark - Get Access Token
- (void)getAccessToken {
    NSString *requestPath = @"/api/access_token";
    NSArray *failedAnswerErrorMessage;
    
    id dataObject;
    
    BasicBody *requestBody = [[BasicBody alloc] init];
    requestBody.grant_type = @"client_credentials";
    requestBody.client_id = CLIENT_ID;
    requestBody.client_secret = CLIENT_SECRET;
    
    dataObject = requestBody;
    
    //Message to show if not succeed
    failedAnswerErrorMessage = [NSArray arrayWithObjects:NSLocalizedString(@"_ERROR_", nil), NSLocalizedString(@"_NO_CATEGORY_ERROR_MSG_", nil), NSLocalizedString(@"_OK_", nil), nil];
    
    [[RKObjectManager sharedManager] postObject:dataObject path:requestPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSArray *results = [mappingResult array];
        
        for (LoginData *login in results) {
            if ([login isKindOfClass:[LoginData class]]) {
                _accessToken = login.access_token;
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:_accessToken forKey:@"TOKEN"];
                [defaults synchronize];
            }
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Fail");
        RKLogError(@"Load failed with error: %@", error);
    }];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"AyiConnection"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
