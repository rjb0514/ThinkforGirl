//
//  UIButton+RJBButtonBlock.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ButtonBlock)(UIButton *);

@interface UIButton (RJBButtonBlock)


/**
 按钮的点击回调
 */
@property (nonatomic, copy) ButtonBlock btnClickBlock;

- (void)buttonAddBlock:(ButtonBlock)block;

@end
