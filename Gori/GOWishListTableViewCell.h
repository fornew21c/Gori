//
//  GOWishListTableViewCell.h
//  Gori
//
//  Created by ji jun young on 2017. 4. 20..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface GOWishListTableViewCell : UITableViewCell


@property (nonatomic, weak) UIView *mainView;

@property (nonatomic, weak) UIImageView *titleImageView;

@property (nonatomic, weak) UILabel *priceLabel;

@property (nonatomic, weak) HCSStarRatingView *averageStar;

@property (nonatomic, weak) UILabel *reviewCountNumberLabel;

@property (nonatomic, weak) UIView *titleFooterView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIView *tuteeCountView;

@property (nonatomic, weak) UILabel *tuteeCountNumberLabel;

@property (nonatomic, weak) UIImageView *tuteeCountIconImageView;


@end
