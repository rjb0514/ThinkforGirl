//
//  RJBRecommendTagsModel.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/12.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 订阅的模型
 */
@interface RJBRecommendTagsModel : NSObject
/** icon */
@property (nonatomic, copy) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;


@end
