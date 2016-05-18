//
//  News.m
//  CoreData-2
//
//  Created by long on 5/18/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "News.h"

@implementation News


- (id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.newsid = [dictionary objectForKey:@"id"];
        self.title = [dictionary objectForKey:@"title"];
        self.descr = [dictionary objectForKey:@"descr"];
        self.imgurl = [dictionary objectForKey:@"imgurl"];
        self.islook = @"0";//0未查看1已查看
    }
    return self;
}


@end
