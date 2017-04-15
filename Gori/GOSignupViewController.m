//
//  GOSignupViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 6..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOSignupViewController.h"
#import "GODataCenter2.h"
#import "GOMainViewController.h"

@interface GOSignupViewController ()

@end

@implementation GOSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pwTF.secureTextEntry = YES;
    self.rePwTF.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signupBtnTouched:(id)sender {
    [[GODataCenter2 sharedInstance] signupWithID:self.nameTF.text email:self.emailTF.text pw:self.pwTF.text repw:self.rePwTF.text completion:^(BOOL isSuccess, id responseData) {
        if (isSuccess) {
           // [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [[GODataCenter2 sharedInstance] setMyLoginToken:[responseData objectForKey:@"key"]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"mainViewSegue" sender:nil];
            });
            
            
            

            NSLog(@"signupBtnTouched success");
        }
        else {
            NSLog(@"%@", [responseData objectForKey:@"username"]);
            NSLog(@"%@", [responseData objectForKey:@"non_field_errors"]);
            NSLog(@"%@", [responseData objectForKey:@"password2"]);
            NSLog(@"%@", [responseData objectForKey:@"name"]);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"회원가입 실패" message:[responseData objectForKey:@"non_field_errors"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                
                
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            });
        }
        
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
