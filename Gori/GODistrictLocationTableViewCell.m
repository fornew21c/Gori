//
//  LocationTableViewCell.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 31..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GODistrictLocationTableViewCell.h"
#import "GODataCenter.h"

@implementation GODistrictLocationTableViewCell

- (void)makingCustomCellObject{
    
    UIView *mainView = [[UIView alloc]init];
    self.mainView = mainView;
    [self.contentView addSubview:self.mainView];
    
    UIImageView *titleImageView = [[UIImageView alloc]init];
    self.titleImageView = titleImageView;
    [self.mainView addSubview:self.titleImageView];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
    [self.titleImageView addSubview:self.titleLabel];
    
    UILabel *titleDetailLabel = [[UILabel alloc]init];
    self.titleDetailLabel = titleDetailLabel;
    self.titleDetailLabel.textColor = [UIColor whiteColor];
    self.titleDetailLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.titleImageView addSubview:self.titleDetailLabel];
    
}

- (void)settingCustomCellObject{
    
    CGFloat offsetX = 0.0f;
    CGFloat offsetY = 0.0f;
    
    self.mainView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 150);
    self.titleImageView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 150);
    
    self.titleLabel.frame = CGRectMake(0, 0, 100, 10);
    self.titleLabel.center = CGPointMake(self.titleImageView.frame.size.width / 2, self.titleImageView.frame.size.height / 2);/Users/JunYoungJee/Desktop/FastCampus/Git/iOS-Fastcampus_Team5/Gori/Pods/AFNetworking
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makingCustomCellObject];
        [self settingCustomCellObject];
    }
    return self;
}




- (void)layoutSubviews{
    
    [self settingCustomCellObject];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
