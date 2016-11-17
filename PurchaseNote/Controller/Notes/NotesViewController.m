//
//  NotesViewController.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/16.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "NotesViewController.h"

@interface NotesViewController ()

@end

static NSString *cellId = @"cellId";

@implementation NotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"备注";
    self.view.backgroundColor = [UIColor blueColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
}


#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = [NSString stringWithFormat:@"第 %zd 行",indexPath.row];
    return cell;
}

#pragma mark - Table View Delegate

@end
