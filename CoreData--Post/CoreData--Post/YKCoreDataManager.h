//
//  YKCoreDataManager.h
//  CoreData--Post
//
//  Created by long on 5/19/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PostCode.h"

@interface YKCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

// 加载数据到数据库
- (void)loadPostCodeData;

- (NSArray *)selectPost;

- (NSArray *)searchPost:(NSString *)searchText;
@end
