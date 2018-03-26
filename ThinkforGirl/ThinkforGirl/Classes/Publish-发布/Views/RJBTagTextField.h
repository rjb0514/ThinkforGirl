//
//  RJBTagTextField.h
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/26.
//  Copyright © 2018年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJBTagTextField : UITextField


@property (nonatomic, copy) void(^deleteBlock)(void);

@end
