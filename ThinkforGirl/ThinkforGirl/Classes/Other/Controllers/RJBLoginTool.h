//
//  RJBLoginTool.h
//  ThinkforGirl
//
//  Created by 茹 on 2018/4/1.
//  Copyright © 2018年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJBLoginTool : NSObject


//获取uid
+ (NSString *)getuserID;

+ (void)setuserID:(NSString *)uid;

@end
