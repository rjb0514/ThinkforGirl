//
//  RJBRecommendTagModel.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBRecommendTagModel.h"

@implementation RJBRecommendTagModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"idString":@"id"};
}


- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end
