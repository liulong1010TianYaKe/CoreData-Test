//
//  AppDelegate.h
//  CoreData-Test1
//
//  Created by long on 5/16/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


/**
 *   NSEntityDescriptor  实体描述符，描述一个实体，可以用来生成实体对应的对象
 *
 *
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext; // 对象管理上下文，负责数据的实际操作
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel; // 对象模型，指定所用对象文件
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;//持久化存储协调器，设置对象的存储方式和数据存放位置 

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

