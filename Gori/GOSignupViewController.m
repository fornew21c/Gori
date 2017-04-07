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
    [[GODataCenter2 sharedInstance] signupWithID:self.nameTF.text email:self.emailTF.text pw:self.pwTF.text repw:self.rePwTF.text completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
           // [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"mainViewSegue" sender:nil];
            });
            
            
            

            NSLog(@"signupBtnTouched success");
        }
        NSLog(@"respons: %@",respons);
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
