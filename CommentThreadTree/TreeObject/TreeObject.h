//
//  TreeObject.h
//  CommentThreadTree
//
//  Created by Steven Chien on 7/27/14.
//  Copyright (c) 2014 stevenchien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeObject : NSObject

//TreeObject's properties
@property (nonatomic, strong) TreeObject *parent;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) BOOL isHidden;

//TreeObject's public methods
- (void)addChild:(TreeObject *)node;
- (NSUInteger)descendants;
- (NSUInteger)depthOfNode;
- (NSArray *)allElementsInOrder;

@end
