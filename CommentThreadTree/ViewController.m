//
//  ViewController.m
//  CommentThreadTree
//
//  Created by Steven Chien on 7/27/14.
//  Copyright (c) 2014 stevenchien. All rights reserved.
//

#import "ViewController.h"
#import "TreeObject.h"
#import "CommentThreadTableViewCell.h"
#import "CommentThreadSectionHeaderView.h"

@interface ViewController () {
    UITableView *commentsThreadTableView;
    NSMutableArray *hiddenSections;
    TreeObject *root;
}

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    hiddenSections = [[NSMutableArray alloc] initWithCapacity:1];
    [self setupTestTree];
    [self setupNavigationBar];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupTestTree
{
    root = [[TreeObject alloc] init];
    root.username = @"old tv shows";
    root.comment = @"kid's shows";
    TreeObject *node1 = [[TreeObject alloc] init];
    node1.username = @"bob the builder";
    node1.comment = @"old kid's show";
    
    TreeObject *node1a = [[TreeObject alloc] init];
    node1a.username = @"bob";
    node1a.comment = @"main character";
    [node1 addChild:node1a];
    TreeObject *node1b = [[TreeObject alloc] init];
    node1b.username = @"lofty";
    node1b.comment = @"blue truck with a crane";
    [node1 addChild:node1b];
    TreeObject *node1c = [[TreeObject alloc] init];
    node1c.username = @"muck";
    node1c.comment = @"red bulldozer";
    [node1 addChild:node1c];
    
    [root addChild:node1];

    TreeObject *node2 = [[TreeObject alloc] init];
    node2.username = @"doug";
    node2.comment = @"old kid's show";
    
    TreeObject *node2a = [[TreeObject alloc] init];
    node2a.username = @"doug";
    node2a.comment = @"main character";
    [node2 addChild:node2a];
    TreeObject *node2b = [[TreeObject alloc] init];
    node2b.username = @"patty";
    node2b.comment = @"doug's crush";
    [node2 addChild:node2b];
    TreeObject *node2c = [[TreeObject alloc] init];
    node2c.username = @"skeeter";
    node2c.comment = @"doug's best friend";
    [node2 addChild:node2c];
    TreeObject *node2d = [[TreeObject alloc] init];
    node2d.username = @"porkchop";
    node2d.comment = @"doug's dog";
    [node2 addChild:node2d];
    TreeObject *node2e = [[TreeObject alloc] init];
    node2e.username = @"roger";
    node2e.comment = @"bully";
    [node2 addChild:node2e];
    
    [root addChild:node2];
    
}

- (void)setupNavigationBar
{
    self.navigationItem.title = @"Topic: TV Shows";
}

- (void)setupTableView
{
    CGRect tableRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    UITableView *table = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = [UIColor whiteColor];
    table.sectionHeaderHeight = 0.0f;
    table.sectionFooterHeight = 0.0f;
    commentsThreadTableView = table;
    
    [self.view addSubview:commentsThreadTableView];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentThreadTableViewCell *cell = [commentsThreadTableView dequeueReusableCellWithIdentifier:@"COMMENTTHREADCELL"];
    if (cell == nil) {
        cell = [[CommentThreadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"COMMENTTHREADCELL" levelOfDepth:0 isHidden:NO];
        [cell.invisTapButton addTarget:self action:@selector(didTapUsername:) forControlEvents:UIControlEventTouchUpInside];
    }
    TreeObject *node = [[root allElementsInOrder] objectAtIndex:indexPath.row];
    cell.level = [node depthOfNode];
    if (node.isHidden) {
        cell.username.textColor = [UIColor grayColor];
    }
    else {
        cell.username.textColor = [UIColor blueColor];
    }
    cell.username.text = node.username;
    cell.comment.text = node.comment;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [root descendants] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeObject *node = [[root allElementsInOrder] objectAtIndex:indexPath.row];
    if (node.isHidden) {
        return 20;
    }
    else {
        CGSize labelSize = [node.comment sizeWithFont:[UIFont systemFontOfSize:16.f]
                                    constrainedToSize:CGSizeMake(self.view.bounds.size.width - ([node depthOfNode] * 20), 1000)
                                        lineBreakMode:NSLineBreakByWordWrapping];
        CGFloat labelHeight = labelSize.height;
        return labelHeight + 20;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDelegate

- (void)didTapUsername:(UIButton *)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:commentsThreadTableView];
    NSIndexPath *indexPath = [commentsThreadTableView indexPathForRowAtPoint:buttonPosition];
    CommentThreadTableViewCell *cell = sender.superview.superview;
    TreeObject *node = [[root allElementsInOrder] objectAtIndex:indexPath.row];
    if (!node.isHidden) {
        [commentsThreadTableView beginUpdates];
        NSArray *array = [self calculateArrayOfIndexPaths:node];
        [commentsThreadTableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
        node.isHidden = YES;
        [commentsThreadTableView endUpdates];
    }
    else {
        [commentsThreadTableView beginUpdates];
        node.isHidden = NO;
        NSArray *array = [self calculateArrayOfIndexPaths:node];
        [commentsThreadTableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
        [commentsThreadTableView endUpdates];
    }
}

- (NSArray *)calculateArrayOfIndexPaths:(TreeObject *)node
{
    @autoreleasepool {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:1];
        for (TreeObject *child in node.children) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:[[root allElementsInOrder] indexOfObject:child] inSection:0];
            [array addObject:indexPath];
            [array addObjectsFromArray:[self calculateArrayOfIndexPaths:child]];
        }
        return array;
    }
}

@end
