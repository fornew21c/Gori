//
//  MainTableViewCell.h
//  Gori
//
//  Created by ji jun young on 2017. 3. 27..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOMainTableViewCell : UITableViewCell

@property (nonatomic, weak) UIView *mainView;

@property (nonatomic, weak) UIImageView *titleImageView;

@property (nonatomic, weak) UIView *titleFooterView;

@property (nonatomic, weak) UIImageView *profileImageView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *tutorNameLabel;

@property (nonatomic, weak) UIView *tuteeCountView;

@property (nonatomic, weak) UILabel *tuteeCountNumberLabel;

@property (nonatomic, weak) UIImageView *tuteeCountIconImageView;

- (void)settingText;

@end
