//
//  RJBRecommendTagTableViewCell.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/12.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBRecommendTagTableViewCell.h"
#import "RJBRecommendTagsModel.h"
#import <UIImageView+WebCache.h>

@implementation RJBRecommendTagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RJBRecommendTagsModel *)model {
    _model = model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.image_list] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.icon.image = [image circleImage];
    }];
    self.namgeLabel.text = model.theme_name;
    
}

@end
