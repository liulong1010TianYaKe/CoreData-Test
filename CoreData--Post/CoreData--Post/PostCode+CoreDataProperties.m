//
//  PostCode+CoreDataProperties.m
//  CoreData--Post
//
//  Created by long on 5/19/16.
//  Copyright © 2016 long. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PostCode+CoreDataProperties.h"

@implementation PostCode (CoreDataProperties)

/**
 *  @synthesize
 
     编译器期间，让编译器自动生成getter/setter方法,当有自定义的存或取方法时，自定义会屏蔽自动生成方法
 
    @dynamic
    告诉编译器，不自动生成getter/setter方法，避免编译期间产生警告，然后由自己实现存取方法
 
    或存取方法在运行时动态创建绑定：主要使用在CoreData的实现NSManagedObject子类时使用，由Core Data框架在程序运行的时动态生成子类属性
 
 */

@dynamic city;
@dynamic cityId;
@dynamic district;
@dynamic id;
@dynamic postCode;
@dynamic province;

@end
