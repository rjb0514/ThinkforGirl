//
//  RJBTopicModel.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/20.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJBTopicModel : NSObject


/**
 昵称
 */
@property (nonatomic, copy) NSString *name;

/**
 头像
 */
@property (nonatomic, copy) NSString *profile_image;


/** 文本 */
@property (nonatomic, copy) NSString *text;

/** 发送事件 */
@property (nonatomic, copy) NSString *create_time;

/** 顶 */
@property (nonatomic, assign) NSInteger ding;

/**
踩 */
@property (nonatomic, assign) NSInteger cai;

/** 转发数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 大图片的url */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的url */
@property (nonatomic, copy) NSString *middle_image;
/** 小图片的url */
@property (nonatomic, copy) NSString *large_image;
/** 类型 */
@property (nonatomic, assign) RJBTopType type;

/** 音频的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频控件的frame */
@property (nonatomic, assign) CGRect videoFrame;


/*辅助模型*/
@property (nonatomic, assign,readonly) CGFloat cellHeight;
/** 图片的frame */
@property (nonatomic, assign) CGRect pictureFrame;

/** 是否图片太大 */
@property (nonatomic, assign,getter=isBigPicture) BOOL bigPicure;

/** 记载当前cell下载图片的进度之 */
@property (nonatomic, assign) CGFloat currentProgress;

/** 声音控件的frame */
@property (nonatomic, assign) CGRect voiceFrame;

/** 最热评论的数组(期望存放的是字典模型) */
@property (nonatomic, strong) NSArray *top_cmt;


@end
