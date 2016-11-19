//
//  PurchaseCategoryView.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/16.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "PurchaseCategoryView.h"
#import "EmptyView.h"
#import "DBHelper.h"
#import "CategoriesItem.h"
#import "ProductsItem.h"

@interface PurchaseCategoryView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_categoryTableView;
    UITableView *_productTableView;
    EmptyView *_emptyView;
}


@end

static NSInteger kCTag = 100;
static NSInteger kPTag = 101;
static NSString *cCellId = @"categoryCell";
static NSString *pCellId = @"productCell";

@implementation PurchaseCategoryView

#pragma mark - Data Change

- (void)setCategoryItemArray:(NSArray *)categoryItemArray {
    _categoryItemArray = categoryItemArray;
    [_categoryTableView reloadData];
}

- (void)setProductItemArray:(NSArray *)productItemArray {
    _productItemArray = productItemArray;
    [_productTableView reloadData];
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    CGFloat screenWidth = self.bounds.size.width;
    CGFloat screenHeight = self.bounds.size.height;
    CGFloat categoryWidth = screenWidth * 0.35;
    CGFloat productWidth = screenWidth * 0.65;
    
    _emptyView = [[EmptyView alloc] initWithFrame:self.bounds];
    
    _categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, categoryWidth, screenHeight)];
    _categoryTableView.tag = kCTag;
    [_categoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cCellId];
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    [self addSubview:_categoryTableView];
    
    _productTableView = [[UITableView alloc] initWithFrame:CGRectMake(categoryWidth, 0, productWidth, screenHeight)];
    _productTableView.tag = kPTag;
    [_productTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:pCellId];
    _productTableView.dataSource = self;
    _productTableView.delegate = self;
    [self addSubview:_productTableView];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == kCTag) {
        if (![DBHelper doesExsistCategory]) {
            [self addSubview:_emptyView];
        } else {
            [_emptyView removeFromSuperview];
        }
        return self.categoryItemArray.count;;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (tableView.tag == kCTag) {
        cell = [tableView dequeueReusableCellWithIdentifier:cCellId];
        CategoriesItem *cItem = self.categoryItemArray[indexPath.row];
        cell.textLabel.text = cItem.categoryName;
        return cell;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:pCellId];
        cell.textLabel.text = [NSString stringWithFormat:@"product %zd",indexPath.row];
        return cell;
    }
}



#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor grayColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = tableView.tag == kCTag ? @"类别" : @"商品";
    return titleLabel;
}


@end
