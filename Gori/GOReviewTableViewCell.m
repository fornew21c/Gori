//
//  GOReviewTableTableViewCell.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 22..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOReviewTableViewCell.h"

@implementation GOReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.reviewerImage.layer.masksToBounds = YES;
    self.reviewerImage.layer.cornerRadius =  roundf(self.reviewerImage.frame.size.width/2.0);;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
