//
//  registerTalentFourthViewController.m
//  Gori
//
//  Created by HeoWoncheol on 2017. 4. 19..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentFourthViewController.h"
#import "GODataCenter2.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]

@interface registerTalentFourthViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tutorImage;
@property (weak, nonatomic) IBOutlet UILabel *priceInfo;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainPriceInfo;

@end

@implementation registerTalentFourthViewController

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
    
    NSNumber *num1 = [GODataCenter2 sharedInstance].selectedModel.pricePerHour;
    NSString *numberStr = [NSNumberFormatter localizedStringFromNumber:num1 numberStyle:NSNumberFormatterDecimalStyle];
    NSString *won = @"￦ ";
    self.priceLabel.text = [[won stringByAppendingString:numberStr] stringByAppendingString:@"원"];
    
    NSString *tmpStr = @"첫 시간 수업에 대하여 결제하실";
    tmpStr = [tmpStr stringByAppendingString:@"\n"];
    tmpStr = [tmpStr stringByAppendingString:@"금액은 ￦ "];
    tmpStr = [[tmpStr stringByAppendingString:numberStr] stringByAppendingString:@"원 입니다."];
    self.priceInfo.text = tmpStr;
    
    NSUInteger time = [[GODataCenter2 sharedInstance].selectedModel.numberOfClass integerValue] * [[GODataCenter2 sharedInstance].selectedModel.hoursPerClass integerValue];
    
    // 총비용
    NSUInteger totalCost = (time * [[GODataCenter2 sharedInstance].selectedModel.pricePerHour integerValue]) ;
    NSNumber *remainCost = [NSNumber numberWithLong:totalCost - [num1 integerValue]];
    NSString *numberStr2 = [NSNumberFormatter localizedStringFromNumber:remainCost numberStyle:NSNumberFormatterDecimalStyle];
    NSString *tmpStr1 = @"첫 수업 진행 후, 수업이 마음에 드시면";
    tmpStr1 = [tmpStr1 stringByAppendingString:@"\n"];
    tmpStr1 = [tmpStr1 stringByAppendingString:@"튜터분께 직접 잔여 금액 ￦ "];
    tmpStr1 = [[tmpStr1 stringByAppendingString:numberStr2] stringByAppendingString:@"원을"];
    tmpStr1 = [tmpStr1 stringByAppendingString:@"\n"];
    tmpStr1 = [tmpStr1 stringByAppendingString:@"입금해주시면 됩니다."];

    self.remainPriceInfo.text = tmpStr1;
    
    
    
    
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
