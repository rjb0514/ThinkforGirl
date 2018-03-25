
#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    RJBTopictypeAll = 1,
    RJBTopictypeVideo = 41,
    RJBTopictypePicture = 10,
    RJBTopictypeCrossTalk = 29,
    RJBTopictypeSound = 31,
} RJBTopType;



//cell的title高度
UIKIT_EXTERN CGFloat const RJBTitleViewH;

UIKIT_EXTERN CGFloat const RJBTitleViewY;

//图片帖子的最大高度
UIKIT_EXTERN CGFloat const RJBTopicCellPictureMaxH;

//图片帖子的固定高度 
UIKIT_EXTERN CGFloat const RJBTopicCellPictureBreakH;

//图片贴子cell的间距
UIKIT_EXTERN CGFloat const RJBTopicCellMargin;

//用户模型 男性
UIKIT_EXTERN NSString *const RJBUserSexMale;
//用户模型 女性
UIKIT_EXTERN NSString *const RJBUserSexFemale;

