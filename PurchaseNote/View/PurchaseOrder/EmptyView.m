//
//  EmptyView.m
//  PurchaseNote
//
//  Created by 樊志远 on 2016/11/17.
//  Copyright © 2016年 fzy. All rights reserved.
//

#import "EmptyView.h"
#import "Masonry.h"

@interface EmptyView()
{
    UIImageView *_emptyImageView;
    UILabel *_emptyLabel;
}

@end

@implementation EmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _emptyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopping_bag"]];
    [self addSubview:_emptyImageView];
    
    _emptyLabel = [[UILabel alloc] init];
    _emptyLabel.textAlignment = NSTextAlignmentCenter;
    _emptyLabel.text = @"还没有商品分类,快去添加一个吧";
    [self addSubview:_emptyLabel];
    
    [self setupUI];
}

- (void)setupUI {
    [_emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset(-50);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(0);
    }];
    
    [_emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_emptyImageView.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(0);
    }];
}

@end
