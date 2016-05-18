//
//  News.h
//  CoreData-2
//
//  Created by long on 5/18/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic, strong) NSString *newsid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *islook;//0未查看1已查看

- (id)initWithDictionary:(NSDictionary*)dictionary;
@end
