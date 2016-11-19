//
//  PurchaseOrderController.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/16.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "PurchaseOrderController.h"
#import "PurchaseCategoryView.h"
#import "AddCategoryViewController.h"
#import "AddProductViewController.h"
#import "DBHelper.h"

@interface PurchaseOrderController ()

/** PurchaseCategoryView */
@property (nonatomic , strong) PurchaseCategoryView *pcView;


@end

@implementation PurchaseOrderController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"进货单";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_add"] style:UIBarButtonItemStyleDone target:self action:@selector(addCategoryOrProducts)];
    
    self.navigationItem.rightBarButtonItem = addBtn;

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    self.pcView = [[PurchaseCategoryView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 113)];
    [self.view addSubview:self.pcView];
    
    [self reloadCategoryTable];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCategoryTable) name:@"kAddCategory" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Event

- (void)addCategoryOrProducts {
    UIAlertAction *addCategoryAction = [UIAlertAction actionWithTitle:@"添加类别信息"
                                                                     style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                                       [self addCategoryInfo];
                                                                   }];
    UIAlertAction *addProductAction = [UIAlertAction actionWithTitle:@"添加商品信息"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                                      [self addProductInfo];
                                                                  }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:addCategoryAction];
    [actionSheet addAction:addProductAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];

}

- (void)addCategoryInfo {
    AddCategoryViewController *ACVC = [[AddCategoryViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ACVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)addProductInfo {
    if (![DBHelper doesExsistCategory]) {
        NSLog(@"请先添加商品分类");
        return;
    } else {
        AddProductViewController *APVC = [[AddProductViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:APVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


#pragma mark - Notification Event

- (void)reloadCategoryTable {
    self.pcView.categoryItemArray = [DBHelper getCategoriesItemArray];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
