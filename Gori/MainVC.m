//
//  MainVC.m
//  AMSlideSample
//
//  Created by Woncheol on 2017. 3. 31..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "MainVC.h"
#import "GODataCenter2.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MainVC ()
<AMSlideMenuDelegate>
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    __block NSString *identifier;

    switch (indexPath.row) {
        case 3:
            identifier = @"mainSegue"; //메인페이지
            break;
        case 4:
            //identifier = @"loginSegue"; //로그인 페이지
            //|| [FBSDKAccessToken currentAccessToken]
            if( [[GODataCenter2 sharedInstance] getMyLoginToken] ) {
                identifier = @"mypageSegue"; //마이 페이지
            }
            else {
                identifier = @"loginSegue"; //로그인 페이지
            }
            break;
        case 5:
           
            if( [[GODataCenter2 sharedInstance] getMyLoginToken] ) {
                
                NSLog(@"여기여기 로그아웃");
                identifier = @"mainSegue";
                [[GODataCenter2 sharedInstance] logoutCompletion:^(BOOL isSuccess, id respons) {
                    if(isSuccess) {
                        NSLog(@"로그아웃에 성공했습니다.");
                        AMSlideMenuMainViewController *amslide = [[AMSlideMenuMainViewController alloc] init];
                        [amslide closeLeftMenu];
                        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
                        [loginManager logOut];
                        [FBSDKAccessToken setCurrentAccessToken:nil];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            identifier = @"mainSegue";
//                        });
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"로그아웃 성공" message:@"로그아웃 하셨습니다." preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                                
                               // dispatch_async(dispatch_get_main_queue(), ^{

                                //});
                                
                                
                            }];

                            
                            
                            [alertController addAction:okAction];
                            [self presentViewController:alertController animated:YES completion:nil];
                        });
                    }
                    else {
                        NSLog(@"로그아웃에 실패했습니다.");
                        
                    }
                }];
            }
            else {
                
                identifier = @"signupSegue"; //회원가입 페이지
            }
            break;
    }
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
    
    [button setImage:[UIImage imageNamed:@"menu@3x.png"] forState:UIControlStateNormal];
    
}

- (void)configureRightMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    button.frame = frame;
    
    [button setImage:[UIImage imageNamed:@"menu@3x.png"] forState:UIControlStateNormal];
    
}

- (CGFloat)leftMenuWidth
{
    return 240;
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

-(IBAction)unwindMainSegue:(UIStoryboardSegue *) sender {
    
    NSLog(@"unwindMainSegue 등록 완료");
}

@end
