//
//  SchoolLocationTableViewCell.h
//  Gori
//
//  Created by ji jun young on 2017. 4. 3..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOSchoolLocationTableViewCell : UITableViewCell

@property (nonatomic, weak) UIView *mainView;

@property (nonatomic, weak) UIImageView *titleImageView;

@property (nonatomic, weak) UILabel *titleLabel;

- (void)settingText;


@end
