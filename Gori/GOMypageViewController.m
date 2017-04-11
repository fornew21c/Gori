//
//  MypageViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 11..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOMypageViewController.h"

@interface GOMypageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registrationButton;
@property (weak, nonatomic) IBOutlet UIButton *classListButton;
@property (weak, nonatomic) IBOutlet UIButton *wishListButton;
@property (weak, nonatomic) IBOutlet UIView *registrationView;
@property (weak, nonatomic) IBOutlet UIView *classListView;
@property (weak, nonatomic) IBOutlet UIView *wishListView;

@end

@implementation GOMypageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)goRegistrationView:(UIButton *)sender {
    [UIView animateWithDuration:1.5 animations:^{
        self.registrationView.alpha = 1.0f;
        self.classListView.alpha = 0.0f;
        self.wishListView.alpha = 0.0f;
    }];
    
}
- (IBAction)goClassListView:(UIButton *)sender {
    [UIView animateWithDuration:1.5 animations:^{
        self.registrationView.alpha = 0.0f;
        self.classListView.alpha = 1.0f;
        self.wishListView.alpha = 0.0f;
    }];
}
- (IBAction)goWishListView:(UIButton *)sender {
    [UIView animateWithDuration:1.5 animations:^{
        self.registrationView.alpha = 0.0f;
        self.classListView.alpha = 0.0f;
        self.wishListView.alpha = 1.0f;
    }];
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
