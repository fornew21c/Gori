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
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]

@interface GOSignupViewController ()
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *contentsView;

@end

@implementation GOSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameTF.tag = 1;
    self.nameTF.delegate = self;
    
    self.emailTF.tag = 2;
    self.emailTF.delegate = self;
    
    self.pwTF.tag = 3;
    self.pwTF.delegate = self;
    
    self.rePwTF.tag = 4;
    self.rePwTF.delegate = self;
    
    
    self.pwTF.secureTextEntry = YES;
    self.rePwTF.secureTextEntry = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,70,70)];
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.textColor = mainColor;
    titleLabel.text = @"회원가입";
    self.navigationItem.titleView = titleLabel;
    
    [self.activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signupBtnTouched:(id)sender {
    [self.activityIndicator startAnimating];
    [[GODataCenter2 sharedInstance] signupWithID:self.nameTF.text email:self.emailTF.text pw:self.pwTF.text repw:self.rePwTF.text completion:^(BOOL isSuccess, id responseData) {
        if (isSuccess) {
           // [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [[GODataCenter2 sharedInstance] setMyLoginToken:[responseData objectForKey:@"key"]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:@"mainViewSegue" sender:nil];
                [self.activityIndicator stopAnimating];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.contentsView setFrame:CGRectMake(0, -50, self.contentsView.frame.size.width, self.contentsView.frame.size.height)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == 1) {
        [self.nameTF resignFirstResponder];
        [self.emailTF becomeFirstResponder];
    }
    else if(textField.tag == 2) {
        [self.emailTF resignFirstResponder];
        [self.pwTF becomeFirstResponder];
    }
    else if(textField.tag == 3) {
        [self.pwTF resignFirstResponder];
        [self.rePwTF becomeFirstResponder];
    }
    else if(textField.tag == 4) {
        [self.rePwTF resignFirstResponder];
        [self.contentsView setFrame:CGRectMake(0, 0, self.contentsView.frame.size.width, self.contentsView.frame.size.height)];
    }
    return YES;
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
