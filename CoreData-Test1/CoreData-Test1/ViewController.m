//
//  ViewController.m
//  CoreData-Test1
//
//  Created by long on 5/16/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"



/**
     两个关系

 
 */


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  /*  NSManagedObjectContext *context = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];
    NSManagedObject *person = nil;
    person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [person setValue:@"long" forKey:@"name"];
    
    //每一个 Managed Object 都有一个全局 ID（类型为：NSManagedObjectID）。Managed Object 会附加到一个 Managed Object Context，我们可以通过这个全局 ID 在 Managed Object Context 查询对应的 Managed Object。
    NSLog(@"%@",[person valueForKey:@"name"]);
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------
#pragma mark - Fetch Requset
- (void)fetchRequst{
   NSManagedObjectContext *context = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];
    NSManagedObjectModel *model = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectModel];
    NSDictionary *entitiles = [model entitiesByName];
    NSEntityDescription *entity = [entitiles valueForKey:@"Person"];
    NSPredicate *predicate;
//    predicate = [NSPredicate predicateWithFormat:@"creationDate > %@",date];
    
}

@end
