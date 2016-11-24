//
//  PNDropDownList.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/19.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "PNDropDownList.h"
#import "DBHelper.h"
#import "CategoriesItem.h"

@interface PNDropDownList()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *_txtField;
}

/** tableView */
@property (nonatomic , strong) UITableView *listTableView;

/** categoryList */
@property (nonatomic , strong) NSMutableArray *categoryArray;



@end

static NSString *cellId = @"reuseCell";
@implementation PNDropDownList

- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] init];

        _listTableView.layer.borderWidth = 1;
        _listTableView.layer.backgroundColor = [UIColor blackColor].CGColor;
        
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.tableFooterView = [[UIView alloc] init];
        [_listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    }
    return _listTableView;
}

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        NSArray *dbList = [DBHelper getCategoriesItemArray];
        if (dbList) {
            _categoryArray = [NSMutableArray arrayWithArray:dbList];
        }
    }
    return _categoryArray;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _txtField = [[UITextField alloc] initWithFrame:self.bounds];
    _txtField.delegate = self;
    _txtField.placeholder = @"--请选择--";
    _txtField.backgroundColor = [UIColor clearColor];
    
    UIView *paddingLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _txtField.leftView = paddingLeftView;
    _txtField.leftViewMode = UITextFieldViewModeAlways;

    UIView *paddingRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    imageView.image = [UIImage imageNamed:@"downArrow"];
    [paddingRightView addSubview:imageView];
    _txtField.rightView = paddingRightView;
    _txtField.rightViewMode = UITextFieldViewModeAlways;
    
    _txtField.layer.borderColor = [UIColor blackColor].CGColor;
    _txtField.layer.borderWidth = 1;
    
    [self addSubview:_txtField];
}

#pragma mark - Text Field Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"begin editing");
    [_txtField resignFirstResponder];
    NSLog(@"view frame : %@",NSStringFromCGRect(self.frame));
    CGFloat tableViewX = self.frame.origin.x;
    CGFloat tableViewY = self.frame.origin.y  + self.frame.size.height;
    CGFloat tableViewWidth = self.frame.size.width;
    CGFloat tableViewHeight = 200;
    
    self.listTableView.frame = CGRectMake(tableViewX, tableViewY, tableViewWidth, tableViewHeight);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (![window.subviews containsObject:self.listTableView]) {
        [window addSubview:self.listTableView];
    } else {
        [self.listTableView removeFromSuperview];
    }
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    CategoriesItem *item = self.categoryArray[indexPath.row];
    cell.textLabel.text = item.categoryName;
    return cell;
    
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoriesItem *item = self.categoryArray[indexPath.row];
    _txtField.text = item.categoryName;
    self.selectedKey = item.categoryName;
    self.selectedValue = item.categoryId;
    [self.listTableView removeFromSuperview];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
