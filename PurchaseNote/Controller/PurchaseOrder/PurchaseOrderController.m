//
//  PurchaseOrderController.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/16.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "PurchaseOrderController.h"
#import "PurchaseCategoryView.h"

@interface PurchaseOrderController ()

/** PurchaseCategoryView */
@property (nonatomic , strong) PurchaseCategoryView *pcView;


@end

@implementation PurchaseOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_add"] style:UIBarButtonItemStyleDone target:self action:@selector(addCategoryOrProducts)];
    
    self.navigationItem.rightBarButtonItem = addBtn;

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    self.pcView = [[PurchaseCategoryView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 113)];
    [self.view addSubview:self.pcView];
    
}

- (void)addCategoryOrProducts {
    self.pcView.categoryCount ++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
