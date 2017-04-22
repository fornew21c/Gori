//
//  registerTalentFourthViewController.m
//  Gori
//
//  Created by HeoWoncheol on 2017. 4. 19..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentFourthViewController.h"
#import "GODataCenter2.h"

@interface registerTalentFourthViewController ()

@end

@implementation registerTalentFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)finishButtonTouched:(id)sender {
    [[GODataCenter2 sharedInstance] registerCreateWithLocationPK:[GODataCenter2 sharedInstance].locationPK
                                                       studentLevel:[GODataCenter2 sharedInstance].studentLevel
                                             studentExperienceMonth:[GODataCenter2 sharedInstance].experienceMonth
                                                     messageToTutor:[GODataCenter2 sharedInstance].messageToTutor
                                                         completion:^(BOOL isSuccess, id responseData) {
            if(isSuccess)
            {
                //NSLog(@"talentRegisterBtnTouched isSuccess: %lu", isSuccess);
                NSLog(@"talentRegisterBtnTouched responseData: %@", [responseData objectForKey:@"detail"]);
    
                //dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"수업등록 성공" message:[responseData objectForKey:@"detail"] preferredStyle:UIAlertControllerStyleAlert];
    
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                    [self performSegueWithIdentifier:@"registerFinalSegue" sender:nil];
                }];
    
    
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                //});
    
            }else
            {
               // dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"수업등록 실패" message:[responseData objectForKey:@"detail"] preferredStyle:UIAlertControllerStyleAlert];
    
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self performSegueWithIdentifier:@"unwindMainSegue" sender:nil];
                }];
    
    
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
             //   });
                NSLog(@"error talentRegisterBtnTouched responseData: %@", responseData);
    
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
