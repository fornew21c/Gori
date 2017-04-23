//
//  registerGuideViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 16..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerGuideViewController.h"
#import "registerTalentFirstViewController.h"
#import "GODataCenter2.h"
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]

@interface registerGuideViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tutorImage;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;



@end

@implementation registerGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,70,70)];
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.textColor = mainColor;
    titleLabel.text = @"결제 프로세스 안내";
    self.navigationItem.titleView = titleLabel;
    
    self.tutorImage.layer.masksToBounds = YES;
    self.tutorImage.layer.cornerRadius =  roundf(self.tutorImage.frame.size.width/2.0);;
    NSLog(@"tutorImgURL: %@", [GODataCenter2 sharedInstance].selectedModel.tutorImgURL);
    self.tutorImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[GODataCenter2 sharedInstance].selectedModel.tutorImgURL]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]}];
    

    NSString *introduceStr = @"안녕하세요? ";
    NSString *userName = [[GODataCenter2 sharedInstance].selectedModel.userDetail objectForKey:@"name"];
    NSString *tutorName = [GODataCenter2 sharedInstance].selectedModel.tutorName;
    introduceStr = [[introduceStr stringByAppendingString:userName] stringByAppendingString:@" \n"];
    introduceStr = [[introduceStr stringByAppendingString:@"튜터 "] stringByAppendingString:tutorName];
    introduceStr = [introduceStr stringByAppendingString:@" 입니다.\n"];
    introduceStr = [[introduceStr stringByAppendingString:@"지금부터 수업신청을 도와드릴께요."] stringByAppendingString:@"\n"];
    introduceStr = [introduceStr stringByAppendingString:@"준비 되셨나요?"];
    NSLog(@"introduceStr: %@", introduceStr);

    self.introduceLabel.text = introduceStr;

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftBtnTouched:(UIButton *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
        if([segue.identifier isEqualToString:@"registerFirstStep"]) {
            registerTalentFirstViewController *rgView = [segue destinationViewController];
            rgView.selectedModel = self.selectedModel;
            //NSLog(@"registerFirstStep: %@", rgView.selectedModel.title);
        }
      

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
