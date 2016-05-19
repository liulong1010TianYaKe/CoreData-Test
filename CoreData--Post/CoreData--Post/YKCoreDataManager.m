//
//  YKCoreDataManager.m
//  CoreData--Post
//
//  Created by long on 5/19/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "YKCoreDataManager.h"

@implementation YKCoreDataManager

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ziyoubang.CoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Post" withExtension:@"momd"];
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
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PostCode.sqlite"];
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


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



#pragma mark -------------------
#pragma mark -  Data Operation

- (void)loadPostCodeData{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"城市邮编最终整理_方便导入数据库" ofType:@"txt"];
        NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF16StringEncoding error:nil];
        NSArray *lineArr = [text componentsSeparatedByString:@"\n"];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"PostCode" inManagedObjectContext:self.managedObjectContext];
        
        for (NSString *line in lineArr) {
            
            NSArray *items = [line componentsSeparatedByString:@"\t"];
            PostCode *postCode = [[PostCode alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
            postCode.id = items[0];
            postCode.province = items[1];
            postCode.city = items[2];
            postCode.district = items[3];
            postCode.cityId = ((NSString *)items[4]).length >=4 ? items[4]:[@"0" stringByAppendingString:items[4]];
            postCode.postCode = items[5];
        }
        
        [self saveContext];

}

- (NSArray *)selectPost{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PostCode"];
    request.sortDescriptors =  @[[NSSortDescriptor sortDescriptorWithKey:@"province" ascending:NO],
                                 [NSSortDescriptor sortDescriptorWithKey:@"city" ascending:NO],
                                 [NSSortDescriptor sortDescriptorWithKey:@"district" ascending:NO]];
    NSError *error = nil;
   return  [self.managedObjectContext executeFetchRequest:request error:&error];
}



- (NSArray *)searchPost:(NSString *)searchText{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PostCode"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"province" ascending:NO],
                                [NSSortDescriptor sortDescriptorWithKey:@"city" ascending:NO],
                                [NSSortDescriptor sortDescriptorWithKey:@"district" ascending:NO]];
    request.predicate = [NSPredicate predicateWithFormat:@"province CONTAINS %@ OR city CONTAINS %@ OR district CONTAINS %@ OR cityId CONTAINS %@ OR postCode CONTAINS %@ OR id CONTAINS %@", searchText, searchText, searchText, searchText, searchText, searchText];
    NSError *error = nil;
    NSArray *tempArr = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    
    return tempArr;
    
}

@end
