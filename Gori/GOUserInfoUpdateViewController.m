//
//  GOUserInfoUpdateViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 16..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOUserInfoUpdateViewController.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"
#import "NetworkModuleMain.h"

@interface GOUserInfoUpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *updateUserTextDataButton;

@end

@implementation GOUserInfoUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)updateUserTextDataAction:(UIButton *)sender {
    [[GODataCenter2 sharedInstance]getMyLoginToken];
    NSString *nameString = [NSString stringWithFormat:@"%@", self.nameTextField.text];
    NSString *nickNameString = [NSString stringWithFormat:@"%@", self.nickNameTextField.text];
    NSString *cellPhoneString = [NSString stringWithFormat:@"%@", self.cellPhoneTextField.text];
    
    [[GODataCenter sharedInstance]updatingUserDetailText:nameString nickName:nickNameString cellPhone:cellPhoneString completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
            NSLog(@"유제인포뷰컨트롤러 버튼 Success");
        }else{
            NSLog(@"유제인포뷰컨트롤러 버튼 눌렸으나 다음으로 안넘어감");
            nil;
        }
    }];
    NSLog(@"유저인포컨트롤러 스트링 체크 : %@ / %@ / %@",nameString, nickNameString, cellPhoneString);
    NSLog(@"유제인포뷰컨트롤러 버튼 눌림");
//    [self dismissViewControllerAnimated:YES completion:nil];
    
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
