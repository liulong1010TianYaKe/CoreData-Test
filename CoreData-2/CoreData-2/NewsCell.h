//
//  NewsCell.h
//  WangyiNews
//
//  Created by iHope on 14-1-10.
//  Copyright (c) 2014年 任海丽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "UIImageView+WebCache.h"

@interface NewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *newsImageView;
@property (strong, nonatomic) IBOutlet UILabel *newsTitle;
@property (strong, nonatomic) IBOutlet UILabel *newsDescr;

-(void)setContent:(News*)info;

@end
