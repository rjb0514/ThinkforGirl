//
//  RJBCommentModel.h
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/4.
//  Copyright © 2018年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RJBUserModel;


//评论模型
@interface RJBCommentModel : NSObject

/** 音评论 播放文件时长 */
@property (nonatomic, copy) NSString *voicetime;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;

/** 点赞个数 */
@property (nonatomic, copy) NSString *like_count;

/** 谁发布的帖子 */
@property (nonatomic, strong) RJBUserModel *userModel;


@end
