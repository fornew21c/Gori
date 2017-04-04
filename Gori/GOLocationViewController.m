//
//  LocationViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 3..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOLocationViewController.h"

@interface GOLocationViewController ()


@property (weak, nonatomic) IBOutlet UIView *schoolLocationView;
@property (weak, nonatomic) IBOutlet UIView *districtLocationView;
@property (weak, nonatomic) IBOutlet UIButton *backToMainViewButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *locationSelection;

@end

@implementation GOLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**************** setting Segmented Selection School and District **************************/

- (IBAction)districtSchoolSelection:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:3 animations:^{
            self.schoolLocationView.alpha = 1.0f;
            self.districtLocationView.alpha = 0.0f;
            NSLog(@"세그멘트 컨트롤 활성화");
        }];
    }
    else{
        [UIView animateWithDuration:3 animations:^{
            self.schoolLocationView.alpha = 0.0f;
            self.districtLocationView.alpha = 1.0f;
        }];
    }
}

//
//if (sender.selectedSegmentIndex == 0) {
//    [UIView animateWithDuration:(0.5) animations:^{
//        self.containerViewA.alpha = 1;
//        self.containerViewB.alpha = 0;
//    }];
//} else {
//    [UIView animateWithDuration:(0.5) animations:^{
//        self.containerViewA.alpha = 0;
//        self.containerViewB.alpha = 1;
//    }];
//}

/**************** button Action ********************************/

- (IBAction)backToMainView:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
