//
//  DetailViewController.h
//  Gori
//
//  Created by Woncheol on 2017. 4. 4..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GODataCenter2.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic) NSNumber* pk;

@property GOTalentDetailModel *selectedModel;
//- (void)setDetailData:(PostModel *)data;
- (void)setSeletedPk:(NSNumber*)selectedPk;
@end
