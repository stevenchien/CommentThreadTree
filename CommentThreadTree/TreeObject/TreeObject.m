//
//  TreeObject.m
//  CommentThreadTree
//
//  Created by Steven Chien on 7/27/14.
//  Copyright (c) 2014 stevenchien. All rights reserved.
//

#import "TreeObject.h"

@implementation TreeObject
@synthesize parent;
@synthesize children;
@synthesize username;
@synthesize comment;
@synthesize index;
@synthesize isHidden;

- (id)init
{
    self = [super init];
    if (self) {
        self.children = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (void)addChild:(TreeObject *)node
{
    node.parent = self;
    [self.children addObject:node];
}

- (NSUInteger)descendants
{
    NSUInteger count = 0;
    if (!self.isHidden) {
        for (TreeObject *node in self.children) {
            count ++;
            if(!node.isHidden) {
                if ([node.children count] > 0) {
                    count += [node descendants];
                }
            }
        }
    }
    return count;
}

- (NSUInteger)depthOfNode
{
    if (self.parent == nil) {
        return 0;
    }
    NSUInteger count = 0;
    count ++;
    count += [self.parent depthOfNode];
    return count;
}

- (NSArray *)allElementsInOrder
{
    @autoreleasepool {
        NSMutableArray *elements = [[NSMutableArray alloc] initWithCapacity:[self descendants]];
        [elements addObject:self];
        if (!self.isHidden) {
            for (TreeObject *node in self.children) {
                [elements addObjectsFromArray:[node allElementsInOrder]];
            }
        }
        return elements;
    }
}

@end
