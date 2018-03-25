//
//  RJBTextView.h
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/20.
//  Copyright © 2018年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJBTextView : UITextView


/** 站位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 站位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
