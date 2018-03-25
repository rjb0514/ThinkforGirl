//
//  RJBRecommendTagModel.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJBRecommendTagModel : NSObject


@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *idString;

@property (nonatomic, copy) NSString *count;

/** 总页数 */
//@property (nonatomic, assign) NSInteger total_page;
/** 总数 */
@property (nonatomic, assign) NSInteger total;

/** 下一页 */
//@property (nonatomic, assign) NSInteger next_page;


/** 当前页 */
@property (nonatomic, assign) NSInteger currentPage;

/**  */
@property (nonatomic, strong) NSMutableArray *users;
@end
