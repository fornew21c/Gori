//
//  LoginViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 3. 31..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "LoginViewController.h"
#import "GODataCenter2.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()
<FBSDKGraphRequestConnectionDelegate, FBSDKLoginButtonDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //Do any additional setup after loading the view.
       FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
        loginButton.center = self.view.center;
        loginButton.delegate = self;
        [self.view addSubview:loginButton];
    
        loginButton.readPermissions =
        @[@"public_profile", @"email", @"user_friends"];
    
        NSLog(@"currentAccessToken: %@", [FBSDKAccessToken currentAccessToken]);
        if ([FBSDKAccessToken currentAccessToken]) {
            // User is logged in, do work such as go to next view controller.
            NSLog(@"login success");
            //loginButton.hidden = TRUE;
        }
    [self.facebookLoginBtn addTarget:self action:@selector(loginButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    self.pwTF.secureTextEntry = YES;
}

- (void)loginButtonTouched {
    if([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"이미 로그인중");
        NSLog(@"facebook access token: %@",[FBSDKAccessToken currentAccessToken]);
        [self performSegueWithIdentifier:@"mainViewSegue" sender:nil];
    }
    else {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                NSLog(@"Process error");
            } else if (result.isCancelled) {
                NSLog(@"Cancelled");
            } else {
                NSLog(@"Logged in");
                NSLog(@"facebook access token: %@",[FBSDKAccessToken currentAccessToken]);
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"mainViewSegue" sender:nil];
                });
                
                
            }
        }];
    }
    
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if(!error) {
        NSLog(@"You've logged in");
        NSLog(@"result: %@", result);
        [self performSegueWithIdentifier:@"mainViewSegue" sender:nil];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"You've logged out");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)emailLoginBtnTouched:(id)sender {
    [[GODataCenter2 sharedInstance] loginWithEmail:self.emailTF.text pw:self.pwTF.text completion:^(BOOL isSuccess, id responseData) {
        
        if(isSuccess)
        {
            NSLog(@"responseData %@",responseData);
            [[GODataCenter2 sharedInstance] setMyLoginToken:[responseData objectForKey:@"key"]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"mainViewSegue" sender:nil];
            });
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"로그인 에러" message:@"로그인에 실패하였습니다." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                
                
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
        
       // NSLog(@"respons %@",respons);
        
    }];
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
