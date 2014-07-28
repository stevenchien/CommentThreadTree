//
//  CommentThreadSectionHeaderView.m
//  CommentThreadTree
//
//  Created by Steven Chien on 7/27/14.
//  Copyright (c) 2014 stevenchien. All rights reserved.
//

#import "CommentThreadSectionHeaderView.h"

@implementation CommentThreadSectionHeaderView
@synthesize username;
@synthesize level;
@synthesize invisTapButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.username = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.username.backgroundColor = [UIColor clearColor];
    self.username.textAlignment = NSTextAlignmentLeft;
    self.username.textColor = [UIColor blueColor];
    self.username.font = [UIFont systemFontOfSize:16.0f];
    self.username.numberOfLines = 1;
    [self addSubview:self.username];
    
    self.invisTapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.invisTapButton.backgroundColor = [UIColor clearColor];
    [self addSubview:self.invisTapButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect contentRect = self.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    frame = CGRectMake((boundsX + self.level) * 20,
                       0,
                       self.bounds.size.width - (self.level * 20),
                       self.bounds.size.height);
    self.username.frame = frame;
}

@end
