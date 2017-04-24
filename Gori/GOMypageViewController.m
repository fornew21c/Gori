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
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]

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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,70,70)];
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.textColor = mainColor;
    titleLabel.text = @"마이페이지";
    self.navigationItem.titleView = titleLabel;
    
}

- (IBAction)signoutAction:(UIButton *)sender {
    [self.activityIndicator startAnimating];
    
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
                    [self.activityIndicator stopAnimating];
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
    
    
    [self.activityIndicator startAnimating];
    
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
                [self.activityIndicator stopAnimating];

            });
        }else{
            UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"OOPS!" message:@"네트워크 연결 상태를 확인하세요" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirm= [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [networkAlert addAction:confirm];
            [self presentViewController:networkAlert animated:nil completion:nil];
            [self.activityIndicator stopAnimating];
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
