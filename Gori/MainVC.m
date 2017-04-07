//
//  MainVC.m
//  AMSlideSample
//
//  Created by Woncheol on 2017. 3. 31..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 0:
            identifier = @"firstSegue";
            break;
        case 1:
            identifier = @"secondSegue";
            break;
        case 2:
            NSLog(@"signupSegue");
            identifier = @"signupSegue";
            break;
    }
    
    NSLog(@"git Test2222");
    return identifier;
}

- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;
    switch (indexPath.row) {
        case 0:
            identifier = @"firstRightSegue";
            break;
        case 1:
            identifier = @"secondRightSegue";
            break;
    }
    
    return identifier;
}


- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"icon-menu"] forState:UIControlStateNormal];
    
}

- (void)configureRightMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"icon-menu"] forState:UIControlStateNormal];
    
}

- (CGFloat)leftMenuWidth
{
    return 180;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}

- (BOOL)deepnessForLeftMenu
{
    return YES;
}

- (BOOL)deepnessForRightMenu
{
    return YES;
}
@end
