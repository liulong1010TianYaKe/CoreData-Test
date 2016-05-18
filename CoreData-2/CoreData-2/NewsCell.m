//
//  NewsCell.m
//  WangyiNews
//
//  Created by iHope on 14-1-10.
//  Copyright (c) 2014年 任海丽. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        _newsTitle.textColor = [UIColor darkGrayColor];
    }
}

-(void)setContent:(News*)info
{
//    [_newsImageView setImageWithURL:[NSURL URLWithString:info.imgurl]];
//    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:info.imgurl] placeholderImage:nil];
//    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:info.imgurl]];
//    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:info.imgurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (image) {
//            _newsImageView.image = image;
//        }
//    }];
    
    
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:info.imgurl] placeholderImage:[UIImage imageNamed:@""]];
    _newsTitle.text = info.title;
    _newsDescr.text = info.descr;
    if ([info.islook isEqualToString:@"1"]) {
        _newsTitle.textColor = [UIColor lightGrayColor];
        _newsDescr.textColor = [UIColor lightGrayColor];
    }
}

@end
