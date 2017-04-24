//
//  LoginViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 3. 31..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "LoginViewController.h"
#import "GODataCenter2.h"
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController ()
<FBSDKGraphRequestConnectionDelegate, FBSDKLoginButtonDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *contentsView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //Do any additional setup after loading the view.
//       FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
//        loginButton.center = self.view.center;
//        loginButton.delegate = self;
//        [self.view addSubview:loginButton];
//    
//        loginButton.readPermissions =
//        @[@"public_profile", @"email", @"user_friends"];
//    
//    //FBSDKAccessToken *fbsaccesstoken = [FBSDKAccessToken alloc] ;
//    //[FBSDKAccessToken alloc] tokenString
//    
////    NSString(@"facebook token string: %@", [FBSDKAccessToken alloc].tokenString);
//       NSLog(@"currentAccessToken: %@", [FBSDKAccessToken currentAccessToken]);
//        if ([FBSDKAccessToken currentAccessToken]) {
//            // User is logged in, do work such as go to next view controller.
//            NSLog(@"login success");
//            //loginButton.hidden = TRUE;
//        }
    [self.activityIndicator stopAnimating];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,70,70)];
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.textColor = mainColor;
    titleLabel.text = @"로그인";
    self.navigationItem.titleView = titleLabel;
    
    self.emailTF.delegate = self;
    self.emailTF.tag = 1;
    
    self.pwTF.delegate = self;
    self.pwTF.tag = 2;
    [self.facebookLoginBtn addTarget:self action:@selector(loginButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    self.pwTF.secureTextEntry = YES;
}

- (void)loginButtonTouched {
    if([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"이미 로그인중");
        NSString *fbAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
        NSLog(@"fbAccessToken: %@", fbAccessToken);
        NSLog(@"facebook access token: %@",[FBSDKAccessToken currentAccessToken]);
       // [self performSegueWithIdentifier:@"mainViewSegue" sender:nil];
        [[GODataCenter2 sharedInstance] loginWithFacebookid:fbAccessToken completion:^(BOOL isSuccess, id responseData) {
            
            if(isSuccess)
            {
                NSLog(@"responseData objectForKey: %@",[responseData objectForKey:@"key"]);
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
                NSString *fbAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
                [[GODataCenter2 sharedInstance] loginWithFacebookid:fbAccessToken completion:^(BOOL isSuccess, id responseData) {
                    
                    if(isSuccess)
                    {
                        NSLog(@"responseData objectForKey: %@",[responseData objectForKey:@"key"]);
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
        }];
    }
    
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if(!error) {
        NSString *fbAccessToken = [FBSDKAccessToken currentAccessToken].tokenString;
        NSLog(@"You've logged in");
        NSLog(@"fbAccessToken: %@", fbAccessToken);
        [[GODataCenter2 sharedInstance] loginWithFacebookid:fbAccessToken completion:^(BOOL isSuccess, id responseData) {
            
            if(isSuccess)
            {
                NSLog(@"responseData objectForKey: %@",[responseData objectForKey:@"key"]);
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
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"You've logged out");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)emailLoginBtnTouched:(id)sender {
    [self.activityIndicator startAnimating];
    [[GODataCenter2 sharedInstance] loginWithEmail:self.emailTF.text pw:self.pwTF.text completion:^(BOOL isSuccess, id responseData) {
        
        if(isSuccess)
        {
            NSLog(@"responseData %@",responseData);
            [[GODataCenter2 sharedInstance] setMyLoginToken:[responseData objectForKey:@"key"]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.contentsView setFrame:CGRectMake(0, -50, self.contentsView.frame.size.width, self.contentsView.frame.size.height)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == 1) {
        [self.emailTF resignFirstResponder];
        [self.pwTF becomeFirstResponder];
    }
    else if(textField.tag == 2) {
        [self.pwTF resignFirstResponder];
            [self.contentsView setFrame:CGRectMake(0, 0, self.contentsView.frame.size.width, self.contentsView.frame.size.height)];
    }
    return YES;
}
@end
