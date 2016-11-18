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

    NSArray *titleArray = @[@"进货单",@"备注"];
    NSArray *imageArray = @[
                            [UIImage imageNamed:@"tabbar_purchase"],
                            [UIImage imageNamed:@"tabbar_note"]
                            ];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [item setTitle:titleArray[idx]];
        [item setImage:imageArray[idx]];
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
