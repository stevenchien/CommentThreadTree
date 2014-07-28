//
//  CommetThreadTableViewCell.m
//  CommentThreadTree
//
//  Created by Steven Chien on 7/27/14.
//  Copyright (c) 2014 stevenchien. All rights reserved.
//

#import "CommentThreadTableViewCell.h"

@implementation CommentThreadTableViewCell
@synthesize comment;
@synthesize username;
@synthesize level;
@synthesize isHidden;
@synthesize invisTapButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier levelOfDepth:(NSUInteger)nodeLevel isHidden:(BOOL)expanded
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.level = nodeLevel;
        self.isHidden = expanded;
        [self setupCell];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCell
{
    self.username = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
    self.username.backgroundColor = [UIColor clearColor];
    self.username.textAlignment = NSTextAlignmentLeft;
    self.username.textColor = [UIColor blueColor];
    self.username.font = [UIFont systemFontOfSize:16.0f];
    self.username.numberOfLines = 1;
    [self addSubview:self.username];
    
    self.comment = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.bounds.size.width, 20)];
    self.comment.backgroundColor = [UIColor clearColor];
    self.comment.textAlignment = NSTextAlignmentLeft;
    self.comment.textColor = [UIColor blackColor];
    self.comment.font = [UIFont systemFontOfSize:16.0f];
    self.comment.numberOfLines = 0;
    
    [self addSubview:self.comment];
    
    self.invisTapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
    self.invisTapButton.backgroundColor = [UIColor clearColor];
    [self addSubview:self.invisTapButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    frame = CGRectMake((boundsX + self.level) * 20,
                       0,
                       self.bounds.size.width - (self.level * 20),
                       20);
    self.username.frame = frame;
    
    frame = self.comment.frame;
    frame.origin.x = (boundsX + self.level) * 20;
    frame.origin.y = 20;
    frame.size.width = self.bounds.size.width - (self.level * 20);
    self.comment.frame = frame;
}

@end
