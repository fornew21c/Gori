//
//  GOWishListTableViewCell.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 20..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOWishListTableViewCell.h"

@implementation GOWishListTableViewCell

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
    
    UILabel *priceLabel = [[UILabel alloc]init];
    self.priceLabel = priceLabel;
    self.priceLabel.textColor = [UIColor colorWithRed:232.0/255.0 green:45.0/255.0 blue:80.0/255.0 alpha:1];
    self.priceLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.titleImageView addSubview:self.priceLabel];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    self.textLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.titleLabel.numberOfLines = 2;
    [self.titleImageView addSubview:self.titleLabel];
    
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
    offsetY += MARGIN * 2;
    
    self.titleLabel.frame = CGRectMake(offsetX, offsetY, self.frame.size.width - offsetX, 20);
    [self.titleLabel sizeToFit];
    
    offsetY += MARGIN * 6;
    
    self.averageStar.frame = CGRectMake(offsetX, offsetY, 100, 30);
    
    offsetX = (MARGIN * 2) + self.averageStar.frame.size.width;
    offsetY += MARGIN / 2;
    self.reviewCountNumberLabel.frame = CGRectMake(offsetX, offsetY, 30, 25);
    
    offsetX = self.titleLabel.frame.origin.x;
    offsetY = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
    self.priceLabel.frame = CGRectMake(offsetX, offsetY, self.averageStar.frame.size.width, 10);
    [self.priceLabel sizeToFit];
    
    offsetX = 0;
    offsetY = 0;
    offsetX += MARGIN;
    offsetY += MARGIN;
    
    self.tuteeCountView.frame = CGRectMake(offsetX, offsetY, 125, 40);
    self.tuteeCountIconImageView.frame = CGRectMake(offsetX, offsetY, 30, 30);
    
    offsetX += MARGIN * 10;
    
    self.tuteeCountNumberLabel.frame = CGRectMake(offsetX, offsetY, 100, 30);
    
    
    
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
