//
//  GOCollectionViewCell.h
//  Gori
//
//  Created by ji jun young on 2017. 3. 30..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIView *mainView;
@property (nonatomic, weak) UILabel *titleLabel;

/**************** Deprecated due to setting tableView Data issue ***********************/
//- (void)inputData;
- (void)makingCustomCellObject;
- (void)settingCellObject;

@end
