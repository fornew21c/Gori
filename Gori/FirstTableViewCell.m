//
//  FirstTableViewCell.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 5..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.joinCountLabel.layer.masksToBounds = YES;
    self.joinCountLabel.layer.cornerRadius = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
