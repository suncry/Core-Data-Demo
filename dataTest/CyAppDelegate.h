//
//  CyAppDelegate.h
//  dataTest
//
//  Created by niko on 14-3-27.
//  Copyright (c) 2014年 Cy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CyAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//引入CoreData框架
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
