//
//  MainTableViewCell.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 27..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "GOMainTableViewCell.h"
#import "GOMainViewController.h"
#import "GODataCenter.h"


@interface GOMainTableViewCell ()


@end

@implementation GOMainTableViewCell

- (void)makingCustomCellObject{

    
    UIView *mainView = [[UIView alloc]init];
    self.mainView = mainView;
    [self.contentView addSubview:self.mainView];
    
    UIImageView *titleImageView = [[UIImageView alloc]init];
    self.titleImageView = titleImageView;
    [self.mainView addSubview:self.titleImageView];
    
    UIView *titleFooterView = [[UIView alloc]init];
    self.titleFooterView = titleFooterView;
    self.titleFooterView.backgroundColor = [UIColor whiteColor];
    [self.titleFooterView setAlpha:0.7f];
    [self.titleImageView addSubview:self.titleFooterView];
    
    UIImageView *profileImageView = [[UIImageView alloc]init];
    self.profileImageView = profileImageView;
    self.profileImageView.layer.cornerRadius = 25;
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.clipsToBounds = YES;
    [self.titleImageView addSubview:self.profileImageView];
    
    UILabel *priceLabel = [[UILabel alloc]init];
    self.priceLabel = priceLabel;
    self.priceLabel.textColor = [UIColor colorWithRed:232.0/255.0 green:45.0/255.0 blue:80.0/255.0 alpha:1];
    self.priceLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.titleImageView addSubview:self.priceLabel];

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
    [self.titleImageView addSubview:self.averageStar];
    
    UILabel *reviewCountNumberLabel = [[UILabel alloc]init];
    self.reviewCountNumberLabel = reviewCountNumberLabel;
    self.reviewCountNumberLabel.textColor = [UIColor colorWithRed:232.0/255.0 green:45.0/255.0 blue:80.0/255.0 alpha:1];
    self.reviewCountNumberLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.titleImageView addSubview:self.reviewCountNumberLabel];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    self.textLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.titleLabel.numberOfLines = 2;
    [self.titleImageView addSubview:self.titleLabel];
    
    UILabel *tutorNameLabel = [[UILabel alloc]init];
    self.tutorNameLabel = tutorNameLabel;
    self.tutorNameLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.titleImageView addSubview:self.tutorNameLabel];
 
    UIView *tuteeCountView = [[UIView alloc]init];
    self.tuteeCountView = tuteeCountView;
    self.tuteeCountView.backgroundColor= [UIColor whiteColor];
    self.tuteeCountView.alpha = 0.4;
    [self.titleImageView addSubview:self.tuteeCountView];
    
    UILabel *tuteeCountNumberLabel = [[UILabel alloc]init];
    self.tuteeCountNumberLabel = tuteeCountNumberLabel;
    self.tuteeCountNumberLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.tuteeCountView addSubview:self.tuteeCountNumberLabel];
    
    UIImageView *tuteeCountIconImageView = [[UIImageView alloc]init];
    self.tuteeCountIconImageView = tuteeCountIconImageView;
    [self.tuteeCountView addSubview:self.tuteeCountIconImageView];
    

}

- (void)settingCustomCellObject{
    const CGFloat MARGIN = 5.0f;
    
    CGFloat offsetX = 0.0f;
    CGFloat offsetY = 0.0f;
    
    self.mainView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 225);
    self.titleImageView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 225);
    
    offsetY = (self.titleImageView.frame.size.height / 2) + (MARGIN *10);
    
    self.titleFooterView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 65);
    
    offsetX += MARGIN * 2;
    offsetY -= MARGIN * 5;
    
    self.profileImageView.frame = CGRectMake(offsetX, offsetY, 50, 50);
    
    offsetX += (self.profileImageView.frame.size.width + MARGIN * 2);
    offsetY += (self.profileImageView.frame.size.height) / 2 + MARGIN;
    
    self.titleLabel.frame = CGRectMake(offsetX, offsetY, self.frame.size.width - offsetX, 20);
    [self.titleLabel sizeToFit];
    
    offsetY += MARGIN * 8;
    
    self.tutorNameLabel.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 10);
    offsetY -= MARGIN * 2;
    offsetX = self.titleFooterView.frame.size.width - self.averageStar.frame.size.width - (MARGIN * 7);
    self.averageStar.frame = CGRectMake(offsetX, offsetY, 100, 30);
    
    offsetX = self.titleFooterView.frame.size.width -self.reviewCountNumberLabel.frame.size.width;
    offsetY += MARGIN / 2;
    
    self.reviewCountNumberLabel.frame = CGRectMake(offsetX, offsetY, 30, 25);
    
    offsetX = 0;
    offsetY = 0;
    offsetX += MARGIN;
    offsetY += MARGIN;
    
    self.tuteeCountView.frame = CGRectMake(offsetX, offsetY, 125, 40);
    self.tuteeCountIconImageView.frame = CGRectMake(offsetX, offsetY, 30, 30);
    offsetX += MARGIN * 10;
    
    self.tuteeCountNumberLabel.frame = CGRectMake(offsetX, offsetY, 100, 30);
    
    offsetX = MARGIN;
    offsetY = self.tutorNameLabel.frame.origin.y - (MARGIN / 2);
    self.priceLabel.frame = CGRectMake(offsetX, offsetY, self.profileImageView.frame.size.width + 10, 10);
    [self.priceLabel sizeToFit];
    
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
