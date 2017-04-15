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
    
    UIImageView *titleImageView = [[UIImageView alloc]init];
    self.titleImageView = titleImageView;
//    [self.titleImageView setContentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:self.titleImageView];
    
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

    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    self.textLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
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
    self.tuteeCountIconImageView.image = [UIImage imageNamed:@"tuteeCountIcon.png"];
    [self.tuteeCountView addSubview:self.tuteeCountIconImageView];
    

}

- (void)settingCustomCellObject{
    const CGFloat MARGIN = 5.0f;
    
    CGFloat offsetX = 0.0f;
    CGFloat offsetY = 0.0f;
//    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.204 green:0.204 blue:0.204 alpha:1]];
//    [self.contentView setBackgroundColor:[UIColor grayColor]];
    self.titleImageView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 300);
    
    offsetY = (self.titleImageView.frame.size.height / 2) + (MARGIN *20);
    
    self.titleFooterView.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 50);
    
    offsetX += MARGIN * 2;
    offsetY -= MARGIN * 5;
    
    self.profileImageView.frame = CGRectMake(offsetX, offsetY, 50, 50);
    
    offsetX += (self.profileImageView.frame.size.width + MARGIN * 2);
    offsetY += (self.profileImageView.frame.size.height) / 2 + MARGIN;
    
    self.titleLabel.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 10);
    
    offsetY += MARGIN * 6;
    
    self.tutorNameLabel.frame = CGRectMake(offsetX, offsetY, self.frame.size.width, 10);
    
    offsetX = 0;
    offsetY = 0;
    offsetX += MARGIN;
    offsetY += MARGIN;
    
    self.tuteeCountView.frame = CGRectMake(offsetX, offsetY, 125, 40);
    self.tuteeCountIconImageView.frame = CGRectMake(offsetX, offsetY, 30, 30);
    
    offsetX += MARGIN * 10;
    
    self.tuteeCountNumberLabel.frame = CGRectMake(offsetX, offsetY, 100, 30);
    
}

//- (void)settingCustomCellObjectColor{
//    self.titleFooterView.backgroundColor = [UIColor whiteColor];
//    self.tuteeCountView.backgroundColor= [UIColor whiteColor];
//}

/**************** Deprecated due to setting tableView Data issue ***********************/
//- (void)settingText:(NSIndexPath *) indexPath{
//
//    NSDictionary *temp = [[GODataCenter sharedInstance].networkDataArray objectAtIndex:indexPath.row];
//    self.tutorNameLabel.text = [[temp objectForKey:@"tutor"] objectForKey:@"name"];
//    self.titleLabel.text = [temp objectForKey:@"title"];
//    self.tuteeCountNumberLabel.text = [temp objectForKey:@"registration_count"];
//    NSLog(@"tutorNameLabel text : %@",self.tutorNameLabel.text);
//    NSLog(@"titleLabel text : %@",self.titleLabel.text);
//    NSLog(@"tuteeCountNumberLabel text : %@",self.tuteeCountNumberLabel.text);
//
//}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makingCustomCellObject];
        [self settingCustomCellObject];
//        [self settingCustomCellObjectColor];
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
