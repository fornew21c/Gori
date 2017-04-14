//
//  SchoolLocationTableViewCell.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 3..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOSchoolLocationTableViewCell.h"
#import "GODataCenter.h"

@implementation GOSchoolLocationTableViewCell


- (void)makingCustomCellObject{
    
    UIView *mainView = [[UIView alloc]init];
    self.mainView = mainView;
    [self.contentView addSubview:self.mainView];
    
    UIImageView *titleImageView = [[UIImageView alloc]init];
    self.titleImageView = titleImageView;
    self.titleImageView.image = [UIImage imageNamed:@"bodyImage.jpg"];
    [self.mainView addSubview:self.titleImageView];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    self.titleLabel.textColor = [UIColor whiteColor];
    //    self.titleLabel.text = [[DataCenter sharedInstance].titleArray objectAtIndex:[DataCenter sharedInstance].currentRow];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.titleImageView addSubview:self.titleLabel];
    
}

- (void)settingCustomCellObject{
    const CGFloat MARGIN = 5.0f;
    
    CGFloat offsetX = 0.0f;
    CGFloat offsetY = 0.0f;
    
    self.mainView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, MARGIN * 30);
    self.titleImageView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, MARGIN * 30);
    
    self.titleLabel.frame = CGRectMake(0, 0, MARGIN * 20, MARGIN * 2);
    self.titleLabel.center = CGPointMake(self.titleImageView.frame.size.width / 2, self.titleImageView.frame.size.height / 2);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)settingCustomCellObjectColor{
    self.mainView.backgroundColor = [UIColor blackColor];
}


//- (void)settingText{
//    self.titleLabel.text = [[GODataCenter sharedInstance].schoolLocationArray objectAtIndex:[GODataCenter sharedInstance].currentRow];
//}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makingCustomCellObject];
        [self settingCustomCellObject];
        [self settingCustomCellObjectColor];
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
