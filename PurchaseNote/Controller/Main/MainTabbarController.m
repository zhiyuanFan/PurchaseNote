//
//  MainTabbarController.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/16.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "MainTabbarController.h"
#import "MainNavigationController.h"
#import "PurchaseOrderController.h"
#import "NotesViewController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewController];
}

- (void)setupChildViewController {
    
    PurchaseOrderController *POVC = [[PurchaseOrderController alloc] init];
    NotesViewController *NTVC = [[NotesViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.viewControllers = @[
                             [self setupNavigatorWithViewController:POVC],
                             [self setupNavigatorWithViewController:NTVC]
                             ];

    NSArray *titleArray = @[@"订单",@"备注"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [item setTitle:titleArray[idx]];
    }];
}

- (MainNavigationController *)setupNavigatorWithViewController:(UIViewController *)viewController {
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:viewController];
    return nav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
