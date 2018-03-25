//
//  RJBRecommendTagCell.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RJBRecommendTagModel;

@interface RJBRecommendTagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *leftRedView;

@property (nonatomic, strong) RJBRecommendTagModel *model;

@end
