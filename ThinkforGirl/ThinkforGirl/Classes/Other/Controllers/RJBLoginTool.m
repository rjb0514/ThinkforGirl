//
//  RJBLoginTool.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/4/1.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBLoginTool.h"

@implementation RJBLoginTool


+ (NSString *)getuserID {
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"uid"];
}

+ (void)setuserID:(NSString *)uid {
    [[NSUserDefaults standardUserDefaults] setValue:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
