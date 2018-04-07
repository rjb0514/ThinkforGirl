//
//  RJBAddTagToolBar.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/25.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBAddTagToolBar.h"
#import "RJBAddTageViewController.h"

@interface RJBAddTagToolBar ()


@property (weak, nonatomic) IBOutlet UIView *topView;

/** 装标签的数组 */
@property (nonatomic, strong) NSMutableArray<UILabel *> *labelList;

/** 添加按钮 */
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation RJBAddTagToolBar

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addBtn.size = addBtn.currentImage.size;
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.addBtn = addBtn;
    [self.topView addSubview:addBtn];
    
    
}

- (void)addBtnClick:(UIButton *)btn {
    RJBFunc;
    
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.presentedViewController;
    RJBAddTageViewController *addVC = [RJBAddTageViewController new];
    
    __weak typeof(self) weakSelf = self;
    //tages
    addVC.tagsBlock = ^(NSArray *arr) {
        NSLog(@"%@",arr);
        [weakSelf creatTags:arr];
    };
    //把text数组传后去
    addVC.labelList = [self.labelList valueForKeyPath:@"text"];
    [nav pushViewController:addVC animated:YES];
}



//创建标签
- (void)creatTags:(NSArray *)arr {
    
    //先清空之前的按钮
    [self.labelList removeAllObjects];
    [self.topView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    [arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.text = obj;
        label.backgroundColor = RJBTagBtnBJ;
        label.font = [UIFont systemFontOfSize:14];
        [label sizeToFit];
        label.width += 2 *RJBTagMargin;
        label.height = 25;
        [self.topView addSubview:label];
        [self.labelList addObject:label];
    }];
    
    [self.labelList enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger idx, BOOL * _Nonnull stop) {
       
        
        if (idx == 0) {
            label.x = 0;
            label.y = 0;
        }else {
            //获取到上一个按钮
            UILabel *lastButton = self.labelList[idx - 1];
            //剩余的宽度
            CGFloat leftWith = self.topView.width - CGRectGetMaxX(lastButton.frame) - RJBTagMargin;
            if (leftWith >= label.width) {//显示在当行
                label.x = CGRectGetMaxX(lastButton.frame) + RJBTagMargin;
                label.y = lastButton.y;
            }else {
                //显示在下一行
                label.x = 0;
                label.y = CGRectGetMaxY(lastButton.frame) + RJBTagMargin;
            }
        }
    }];
    
    
    [self addSubview:self.addBtn];
    //获取到上一个按钮
    UILabel *lastButton = self.labelList.lastObject;
    //剩余的宽度
    CGFloat leftWith = self.topView.width - CGRectGetMaxX(lastButton.frame) - RJBTagMargin;
    if (leftWith >= self.addBtn.width) {//显示在当行
        self.addBtn.x = CGRectGetMaxX(lastButton.frame) + RJBTagMargin;
        self.addBtn.y = lastButton.y;
    }else {
        //显示在下一行
        self.addBtn.x = 0;
        self.addBtn.y = CGRectGetMaxY(lastButton.frame) + RJBTagMargin;
    }
    
    
    //整体的高度
    self.height = CGRectGetMaxY(self.addBtn.frame) + RJBTagMargin + 45;
    
}


- (NSMutableArray<UILabel *> *)labelList {
    if (!_labelList) {
        _labelList = [NSMutableArray array];
    }
    return _labelList;
}

@end
