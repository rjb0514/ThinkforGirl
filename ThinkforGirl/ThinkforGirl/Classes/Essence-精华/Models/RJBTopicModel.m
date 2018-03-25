//
//  RJBTopicModel.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/20.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBTopicModel.h"
#import "NSDate+RJBExtension.h"

@implementation RJBTopicModel {
    
    
    CGFloat _cellHeight;
}


+(NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"small_image":@"image0",@"middle_image":@"image1",@"large_image":@"image2"};
}

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"top_cmt":@"RJBUserModel"};
}


- (NSString *)create_time {
    //现在
    NSDate *nowDate = [NSDate date];
    
    //过去
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *creatDate = [fmt dateFromString:_create_time];
    
    
    
    //如果是今年
    if ([creatDate isYear]) {
        
        //今天
        if ([creatDate isToday]) {
            
            //相差多少时间
            NSDateComponents *components =  [nowDate rjb_deteFrom:creatDate];
            if (components.hour >= 1) {
                //相差1小时以上
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
            }else if (components.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            }else {
                //小于1分钟
                return  @"刚刚";
            }
            
            
            //昨天
        }else if ([creatDate isYesterday]) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return  [fmt stringFromDate:creatDate];
            
            //其它
        }else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:creatDate];
        }
        
        
    }else {
        //非今年 就显示原来的
        return _create_time;
        
    }
    
    
    
    /*
     今年发的
     今天
     1分钟内
     1小时内
     其它
     刚刚
     昨天
     其它
     
     
     非今年发的
     ----
     
     */
    
    
    
}


- (CGFloat)cellHeight {

    NSLog(@"begin---\n%@\n%@\n%@\nend---",self.small_image,self.middle_image,self.large_image);
    
    if (_cellHeight != 0) {
        return _cellHeight;
    }
    
    //文字的y值
    CGFloat textY = 55;
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
    //    CGFloat textH = [modle.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
    CGFloat textH = [_text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    
    //文字高度 + 间距10 +底部的高度 +图片的高度
    _cellHeight =  textY + textH + 44 +10 + 10 ;
    
    //根据段子的类型来计算高度
    if (self.type == RJBTopictypePicture) {
        
        //图片的宽度
        CGFloat pictureWith = maxSize.width;
        //图片显示出来的高度
        CGFloat pictureHeight = pictureWith * self.height / self.width;
        //如果超出了最大高度
        if (pictureHeight >= RJBTopicCellPictureMaxH) {
            pictureHeight = RJBTopicCellPictureBreakH;
            self.bigPicure = YES;
        }
        
        
        _cellHeight += pictureHeight;
        self.pictureFrame = CGRectMake(10, textY + textH, pictureWith, pictureHeight);
    }else if (self.type == RJBTopictypeSound) {
        //声音帖子
        CGFloat voiceX = RJBTopicCellMargin;
        CGFloat voiceY = RJBTopicCellMargin + textY + textH + RJBTopicCellMargin;
        CGFloat voiceW = maxSize.width;
        CGFloat voiceH = voiceW * self.height / self.width;
        _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
        
        //Cell的高度
        _cellHeight += voiceH + RJBTopicCellMargin;
        
    }else if (self.type == RJBTopictypeVideo) {
        CGFloat voiceX = RJBTopicCellMargin;
        CGFloat voiceY = RJBTopicCellMargin + textY + textH + RJBTopicCellMargin;
        CGFloat voiceW = maxSize.width;
        CGFloat voiceH = voiceW * self.height / self.width;
        _videoFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
        
        //Cell的高度
        _cellHeight += voiceH + RJBTopicCellMargin;
    }
    
    return _cellHeight;
}


@end
