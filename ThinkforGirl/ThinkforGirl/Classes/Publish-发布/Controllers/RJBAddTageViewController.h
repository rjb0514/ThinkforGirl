//
//  RJBAddTageViewController.h
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/25.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBBaseViewController.h"


/**
 添加标签控制器
 */
@interface RJBAddTageViewController : RJBBaseViewController

/** 获取tages的block */
@property (nonatomic, copy) void(^tagsBlock)(NSArray *arr);

/** 标签数组 */
@property (nonatomic, copy) NSArray *labelList;


@end
