//
//  registerTalentFifthViewController.m
//  Gori
//
//  Created by HeoWoncheol on 2017. 4. 19..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentFifthViewController.h"
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]

@interface registerTalentFifthViewController ()

@end

@implementation registerTalentFifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,70,70)];
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.textColor = mainColor;
    titleLabel.text = @"수업신청 완료";
    self.navigationItem.titleView = titleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)confirmBtnTouched:(id)sender {
   [self performSegueWithIdentifier:@"unwindMainSegue" sender:nil];
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
