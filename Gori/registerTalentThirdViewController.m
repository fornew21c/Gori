//
//  registerTalentThirdViewController.m
//  Gori
//
//  Created by HeoWoncheol on 2017. 4. 19..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentThirdViewController.h"
#import "GODataCenter2.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]

@interface registerTalentThirdViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cellphone;
@property (weak, nonatomic) IBOutlet UIImageView *tutorImage;

@end

@implementation registerTalentThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,70,70)];
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.textColor = mainColor;
    titleLabel.text = @"수업신청";
    self.navigationItem.titleView = titleLabel;
    self.tutorImage.layer.masksToBounds = YES;
    self.tutorImage.layer.cornerRadius =  roundf(self.tutorImage.frame.size.width/2.0);;
    [self.tutorImage sd_setImageWithURL:[GODataCenter2 sharedInstance].selectedModel.tutorImgURL];
    
    NSLog(@"cellphone: %@", [[GODataCenter2 sharedInstance].selectedModel.userDetail objectForKey:@"cellphone"]);
    self.cellphone.text = [[GODataCenter2 sharedInstance].selectedModel.userDetail objectForKey:@"cellphone"];

    
    
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
