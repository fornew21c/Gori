//
//  registerTalentSecondViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 16..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentSecondViewController.h"

@interface registerTalentSecondViewController ()
@property (weak, nonatomic) IBOutlet UIView *experienceView;

@end

@implementation registerTalentSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.experienceView.layer.borderWidth = 1;
    self.experienceView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.experienceView.layer.masksToBounds = 5;
    self.experienceView.layer.cornerRadius = 5;
    
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
