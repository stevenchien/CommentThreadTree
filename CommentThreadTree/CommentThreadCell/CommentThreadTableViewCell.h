//
//  CommetThreadTableViewCell.h
//  CommentThreadTree
//
//  Created by Steven Chien on 7/27/14.
//  Copyright (c) 2014 stevenchien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentThreadTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *comment;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, assign) BOOL isHidden;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier levelOfDepth:(NSUInteger)nodeLevel isHidden:(BOOL)expanded;

@end
