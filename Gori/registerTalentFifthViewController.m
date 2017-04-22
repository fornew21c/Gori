//
//  registerTalentFifthViewController.m
//  Gori
//
//  Created by HeoWoncheol on 2017. 4. 19..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentFifthViewController.h"

@interface registerTalentFifthViewController ()

@end

@implementation registerTalentFifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
