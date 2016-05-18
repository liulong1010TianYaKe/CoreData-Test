//
//  CoreDataManager.m
//  CoreData-2
//
//  Created by long on 5/18/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "CoreDataManager.h"





@implementation CoreDataManager


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (void)saveContext{
    
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved eror %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark -------------------
#pragma mark - Core Data  stack
- (NSManagedObjectContext *)managedObjectContext{
    
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managedObjectContext;
}


- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NewsModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applictionDocumentsDirectory] URLByAppendingPathComponent:@"NewsModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"addPersistentStoreWithType error %@ ,%@",error,[error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSURL *)applictionDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark -------------------
#pragma mark -  Core Data  Operation

- (void)insertCoreData:(NSMutableArray *)dataArray{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (News *info in dataArray) {
        
     NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        News *newsInfo = (News*)managedObject;
        newsInfo.newsid = info.newsid;
        newsInfo.title = info.title;
        newsInfo.imgurl = info.imgurl;
        newsInfo.descr = info.descr;
        newsInfo.islook = info.islook;
        
        NSError *error;
        if(![context save:&error])
        {
            NSLog(@"不能保存：%@",[error localizedDescription]);
        }
    }
    
}

- (NSMutableArray *)selectData:(int)pageSize andOffset:(int)currentPage{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // 限定查询结果的数量
    //setFetchLimit
    // 查询的偏移量
    //setFetchOffset
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setFetchLimit:pageSize];
    [fetchRequest setFetchOffset:currentPage];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchhedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (News *info in fetchhedObjects) {
        NSLog(@"id:%@",info.newsid);
        NSLog(@"ttile:%@",info.title);
        [resultArray addObject:info];
    }
    
    return resultArray;
}

- (void)deleteData{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count]) {
        for (NSManagedObject *obj in datas) {
            [context deleteObject:obj];
        }
        if (![context save:&error]) {
            NSLog(@" deleteData error : %@",error);
        }
    }
}

- (void)updateData:(NSString *)newsId withIsLook:(NSString *)islook{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"newsid like[cd] %@",newsId];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:TableName inManagedObjectContext:context]];
    [request setPredicate:predicate]; // 相当于sqlite中的查询条件
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    for (News *info in result) {
        info.islook = islook;
    }
    
    
    if ([context save:&error]) {
        NSLog(@"跟新成功");
    }
    
}
@end
