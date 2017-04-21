//
//  GOClassListTableViewCell.h
//  Gori
//
//  Created by ji jun young on 2017. 4. 20..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOClassListTableViewCell : UITableViewCell

@property (nonatomic, weak) UIView *mainView;

@property (nonatomic, weak) UIImageView *titleImageView;

@property (nonatomic, weak) UIView *titleFooterView;

@property (nonatomic, weak) UIImageView *profileImageView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *tutorNameLabel;

@property (nonatomic, weak) UIView *tuteeCountView;

@property (nonatomic, weak) UILabel *tuteeCountNumberLabel;

@property (nonatomic, weak) UIImageView *tuteeCountIconImageView;



@end
