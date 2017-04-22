//
//  MypageViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 11..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOMypageViewController.h"
#import "GOMainViewController.h"
#import "MainVC.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface GOMypageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *classListButton;
@property (weak, nonatomic) IBOutlet UIButton *wishListButton;
@property (weak, nonatomic) IBOutlet UIButton *questionListButton;
@property (weak, nonatomic) IBOutlet UIButton *userInfoSettingButton;
@property (weak, nonatomic) IBOutlet UIView *classListView;
@property (weak, nonatomic) IBOutlet UIView *wishListView;
@property (weak, nonatomic) IBOutlet UIView *questionView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileEmailLabel;
@property (nonatomic, strong) NSMutableArray *pkMutableArray;

@end

@implementation GOMypageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.classListView.alpha = 1.0f;
    self.wishListView.alpha = 0.0f;
    self.questionView.alpha = 0.0f;
    
    self.userInfoSettingButton.layer.cornerRadius = 40;
    self.userInfoSettingButton.layer.masksToBounds = YES;
    self.userInfoSettingButton.clipsToBounds = YES;
    
}

- (IBAction)signoutAction:(UIButton *)sender {
    [[GODataCenter2 sharedInstance] logoutCompletion:^(BOOL isSuccess, id respons) {
        if(isSuccess) {
            NSLog(@"로그아웃에 성공했습니다.");
            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
            [loginManager logOut];
            [FBSDKAccessToken setCurrentAccessToken:nil];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"로그아웃" message:@"로그아웃에 성공했습니다." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                //[self performSegueWithIdentifier:@"mainVCSegue" sender:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                   [self performSegueWithIdentifier:@"mainSegue" sender:nil];
                });

            }];
            
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
            NSLog(@"로그아웃에 실패했습니다.");

        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)goClassListView:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.classListView.alpha = 1.0f;
        self.wishListView.alpha = 0.0f;
        self.questionView.alpha = 0.0f;
    }];
}
- (IBAction)goWishListView:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.classListView.alpha = 0.0f;
        self.wishListView.alpha = 1.0f;
        self.questionView.alpha = 0.0f;
    }];
}
- (IBAction)goQuestionListView:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.classListView.alpha = 0.0f;
        self.wishListView.alpha = 0.0f;
        self.questionView.alpha = 1.0f;
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [[GODataCenter sharedInstance]receiveServerUserDetailDataWithCompletionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *temp = [GODataCenter sharedInstance].networkUserDetailDictionary;
                self.profileNameLabel.text = [temp objectForKey:@"name"];
                self.profileEmailLabel.text = [temp objectForKey:@"user_id"];
                self.profileNickNameLabel.text = [temp objectForKey:@"nickname"];
                NSURL *profileURL = [NSURL URLWithString:[temp objectForKey:@"profile_image"]];
                [self.userInfoSettingButton setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:profileURL]] forState:UIControlStateNormal];
                [self.userInfoSettingButton.imageView sd_setImageWithURL:profileURL];
                
                NSLog(@"ReceivingServerData and ReloadingData is Completed");
                
            });
        }else{
            NSLog(@"ReceivingServerData and ReloadingData is Failed");
        }
    }];
    
}

-(IBAction)unwindSegue:(UIStoryboardSegue*)sender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
