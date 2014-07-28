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
@synthesize level;
@synthesize isHidden;

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
    self.comment = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.comment.backgroundColor = [UIColor clearColor];
    self.comment.textAlignment = NSTextAlignmentLeft;
    self.comment.textColor = [UIColor blackColor];
    self.comment.font = [UIFont systemFontOfSize:16.0f];
    self.comment.numberOfLines = 0;
    
    [self addSubview:self.comment];
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
                       self.bounds.size.height);
    self.comment.frame = frame;
}

@end
