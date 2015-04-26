//
//  DMRCollectionViewCell.m
//  CollectionView
//
//  Created by Damir Tursunovic on 2/19/13.
//  Copyright (c) 2013 Damir Tursunovic (damir.me). All rights reserved.
//

#import "DMRCollectionViewCell.h"

@implementation DMRCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageView = [[UIImageView alloc] init];
        [_imageView setClipsToBounds:YES];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height-50.0, self.bounds.size.width, 40.0)];
        [_titleLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [_titleLabel setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.3]];
//        [_titleLabel setFont:[UIFont boldSystemFontOfSize:40.0]];
//        [_titleLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}


-(void)layoutSubviews
{
    [_imageView setFrame:self.bounds];
}


@end
