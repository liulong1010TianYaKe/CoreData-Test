//
//  ContactModel+CoreDataProperties.h
//  CoreData-Test1
//
//  Created by long on 5/18/16.
//  Copyright © 2016 long. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ContactModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *sex;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *birthDate;
@property (nullable, nonatomic, retain) NSManagedObject *detail;

@end

NS_ASSUME_NONNULL_END
