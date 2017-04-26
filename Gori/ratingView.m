//
//  ratingView.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 26..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "ratingView.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface ratingView ()
@property (nonatomic, weak) HCSStarRatingView *averageStar;

@end

@implementation ratingView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib {
    [super awakeFromNib];
    HCSStarRatingView *averageStar = [[HCSStarRatingView alloc]init];
    self.averageStar = averageStar;
    self.averageStar.maximumValue = 5;
    self.averageStar.minimumValue = 0;
    self.averageStar.value = 0;
    self.averageStar.tintColor = [UIColor colorWithRed:232.0/255.0 green:45.0/255.0 blue:80.0/255.0 alpha:1];
    self.averageStar.allowsHalfStars = YES;
    self.averageStar.value = 2.5f;
    self.averageStar.accurateHalfStars = YES;
    self.averageStar.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0];
}


@end
