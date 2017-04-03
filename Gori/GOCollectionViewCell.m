//
//  GOCollectionViewCell.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 30..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "GOCollectionViewCell.h"
#import "GODataCenter.h"

/**************** collectionViewConcept is Suspended ********************************/

@implementation GOCollectionViewCell


- (void)makingCustomCellObject{
    
    UIView *mainView = [[UIView alloc]init];
    self.mainView = mainView;
    [self.contentView addSubview:self.mainView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:11.0f];
    [self.mainView addSubview:self.titleLabel];
    
}

- (void)settingCellObject{
    const CGFloat MARGIN = 5.0f;
    CGFloat offsetX;
    CGFloat offsetY;
    offsetX = 0.0f;
    offsetY = 0.0f;
    
    self.mainView.frame = CGRectMake(offsetX, offsetY, MARGIN * 10, MARGIN * 5);
    self.mainView.backgroundColor = [UIColor lightGrayColor];
    self.mainView.layer.cornerRadius = 25;
    self.mainView.layer.masksToBounds = YES;
    
    self.titleLabel.frame = CGRectMake(offsetX, offsetY, MARGIN * 6, MARGIN * 4);
    self.titleLabel.center = CGPointMake(self.mainView.frame.size.width / 2, self.mainView.frame.size.height / 2);
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self makingCustomCellObject];
    [self settingCellObject];
}

- (void)inputData{
    self.titleLabel.text = [[GODataCenter sharedInstance].categoryArray objectAtIndex:[GODataCenter sharedInstance].currentRow];
}

@end
