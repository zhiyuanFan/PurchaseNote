//
//  AddCategoryViewController.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "AddCategoryViewController.h"
#import "Masonry.h"
#import "DBHelper.h"
#import "CategoriesItem.h"
#import "PNTextField.h"

@interface AddCategoryViewController ()
{
    UITextField *_txtCategoryName;
    UIButton *_submitBtn;
    UIButton *_cancelBtn;
    CGFloat _keyboardHeight;
}
@end

@implementation AddCategoryViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加商品类别";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - init subviews

- (void)setupSubViews {
    _txtCategoryName = [[PNTextField alloc] initWithPlaceholderText:@"请输入商品类别"];
    [_txtCategoryName becomeFirstResponder];
    [self.view addSubview:_txtCategoryName];
    
    _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitBtn setBackgroundColor:[UIColor orangeColor]];
    _submitBtn.layer.cornerRadius = 20;
    _submitBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_submitBtn setTitle:@"添加" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submitBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setBackgroundColor:[UIColor orangeColor]];
    _cancelBtn.layer.cornerRadius = 20;
    _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
    [self setupUI];
}

- (void)setupUI {
    CGFloat margin = 20;
    [_txtCategoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(40);
    }];
    
}

#pragma mark - Events

- (void)submitBtnOnClick {
    CategoriesItem *cItem = [[CategoriesItem alloc] init];
    cItem.categoryId = [DBHelper getMaxCategoryId];
    if (cItem.categoryId == errorCategoryId) {
        NSLog(@"添加失败:数据库数据错误");
    } else {
        cItem.categoryName = _txtCategoryName.text;
        if ([cItem.categoryName isEqualToString:@""] || !cItem.categoryName) {
            NSLog(@"添加失败:缺少参数");
        } else {
            [DBHelper addCategoryWithCategoriesItem:cItem];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kAddCategory" object:nil];
        }
    }
    [self dismissVC];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self.view]) {
        [self.view endEditing:YES];
    }
}


#pragma mark - 根据键盘的显示和隐藏修改按钮的约束
- (void)keyboardWillShow:(NSNotification *)note {
    CGRect keyboardBounds = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _keyboardHeight = keyboardBounds.size.height;
    [self updateSubmitBtnConstraints];
}

- (void)keyboardWillHide:(NSNotification *)note {
    _keyboardHeight = 0;
    [self updateSubmitBtnConstraints];
}

- (void)updateSubmitBtnConstraints {
    CGFloat margin = 20;
    CGFloat btnWidth = (self.view.bounds.size.width - 3 * margin) / 2;
    CGFloat btnHeight = 40;
    
    [_submitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-_keyboardHeight - 20);
        make.left.mas_equalTo(margin);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    
    [_cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-_keyboardHeight - 20);
        make.right.mas_equalTo(-margin);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];

    
    [self.view setNeedsUpdateConstraints];
    [UIView animateKeyframesWithDuration:0.25
                                   delay:0
                                 options:7<<16
                              animations:^{
                                  [self.view layoutIfNeeded];
                              }
                              completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
