//
//  CommentThreadSectionHeaderView.h
//  CommentThreadTree
//
//  Created by Steven Chien on 7/27/14.
//  Copyright (c) 2014 stevenchien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentThreadSectionHeaderView : UIView

@property (nonatomic, strong) UILabel *username;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, strong) UIButton *invisTapButton;

@end
