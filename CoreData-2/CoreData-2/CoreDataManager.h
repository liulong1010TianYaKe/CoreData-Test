//
//  CoreDataManager.h
//  CoreData-2
//
//  Created by long on 5/18/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "News.h"

#define TableName  @"News"

@interface CoreDataManager : NSObject


@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong,readonly) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applictionDocumentsDirectory;

/**< 插入数据 */
- (void)insertCoreData:(NSMutableArray *)dataArray;

/**< 查询 */
- (NSMutableArray *)selectData:(int)pageSize andOffset:(int)currentPage;

/**< 删除 */
- (void)deleteData;

/**< 更新 */
- (void)updateData:(NSString *)newsId withIsLook:(NSString *)islook;
@end
