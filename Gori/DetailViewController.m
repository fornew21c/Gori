//
//  DetailViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 4..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "GODataCenter2.h"
#import "GOTalentDetailModel.h"

@interface DetailViewController ()
<UIScrollViewDelegate>
@property (nonatomic, strong) GOTalentDetailModel *viewData;

@property (weak, nonatomic) IBOutlet UILabel *talentRegion;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *hoursPerClass;
@property (weak, nonatomic) IBOutlet UILabel *joinCntLabel;
@property (weak, nonatomic) IBOutlet UILabel *talentTitle;
@property (weak, nonatomic) IBOutlet UILabel *pricePerHour;
@property (weak, nonatomic) IBOutlet UILabel *maxNumber;
@property (weak, nonatomic) IBOutlet UILabel *cntTime;
@property (weak, nonatomic) IBOutlet UILabel *totalCost;
@property (weak, nonatomic) IBOutlet UIImageView *tutorImage;
@property (weak, nonatomic) IBOutlet UILabel *tutorName;
@property (weak, nonatomic) IBOutlet UILabel *tutorMessage;
@property (weak, nonatomic) IBOutlet UILabel *tutorInfo;
@property (weak, nonatomic) IBOutlet UILabel *classInfo;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.delegate = self;
   
    self.joinCntLabel.layer.masksToBounds = YES;
    self.joinCntLabel.layer.cornerRadius = 15;
    
    //self.tutorImage.clipsToBounds = YES;
    self.tutorImage.layer.masksToBounds = YES;
    self.tutorImage.layer.cornerRadius =  roundf(self.tutorImage.frame.size.width/2.0);;
  
    [[GODataCenter2 sharedInstance] requestPostRetrieveID:self.pk completion:^(BOOL isSuccess, id responseData) {
        
        if(isSuccess)
        {
           // NSLog(@"isSuccess: %lu", isSuccess);
            //NSLog(@"title: %@", [responseData objectForKey:@"title"]);
            
            self.selectedModel = [GOTalentDetailModel modelWithData:responseData];
            NSLog(@"title: %@", self.selectedModel.title);
            NSLog(@"region: %@", self.selectedModel.region);
            [self layoutDataInView];
            
        }else
        {
 
        }
    }];
}

- (void)setSeletedPk:(NSNumber *)selectedPk {
    self.pk = selectedPk;
}

- (void)layoutDataInView {
    self.talentTitle.text = self.selectedModel.title;
    self.talentRegion.text =  self.selectedModel.region;
    self.coverImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.selectedModel.img_cover_url]];
    self.hoursPerClass.text = [self.selectedModel.hoursPerClass stringValue];
    
    NSString *temp = @" 누적인원: ";
    self.joinCntLabel.text = [temp stringByAppendingString:[self.selectedModel.registrationCount stringValue]];
    
    NSNumber *num1 = self.selectedModel.pricePerHour;
    NSString *numberStr = [NSNumberFormatter localizedStringFromNumber:num1 numberStyle:NSNumberFormatterDecimalStyle];
    NSString *won = @"￦ ";
    self.pricePerHour.text = [won stringByAppendingString:numberStr];
    
    self.maxNumber.text = [[[self.selectedModel.minNumberStudent stringValue] stringByAppendingString:@"~"] stringByAppendingString:[self.selectedModel.maxNumberStudent stringValue]];
    
    // 총횟수/시간
    NSString *str = @" 총 ";
    NSString *str2 = @"회 ";
    NSString *str3 = @"시간";
    NSUInteger time = [self.selectedModel.numberOfClass integerValue] * [self.selectedModel.hoursPerClass integerValue];
    self.cntTime.text = [[[[str stringByAppendingString:[self.selectedModel.numberOfClass stringValue]] stringByAppendingString:str2] stringByAppendingString:[NSString stringWithFormat:@"%lu",time ]] stringByAppendingString:str3];
    
    // 총비용
    NSNumber *totalCost = [NSNumber numberWithLong:(time * [self.selectedModel.pricePerHour integerValue]) ];
    NSString *numberStr2 = [NSNumberFormatter localizedStringFromNumber:totalCost numberStyle:NSNumberFormatterDecimalStyle];
    
    self.totalCost.text = [[won stringByAppendingString:numberStr2] stringByAppendingString:@"원 "];
    
    //튜터정보
    self.tutorImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.selectedModel.tutorImgURL]];
    self.tutorName.text = self.selectedModel.tutorName;
    
    self.tutorMessage.text = self.selectedModel.tutorMessage;
    self.tutorInfo.text = self.selectedModel.tutorInfo;
    
    //수업정보
    self.classInfo.text = self.selectedModel.classInfo;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView.contentOffset.x: %lf", scrollView.contentOffset.x);
    if(scrollView.contentOffset.x == 0) {
        self.pageControl.currentPage = 0;
    }
    else if(scrollView.contentOffset.x == self.imageScrollView.frame.size.width) {
        self.pageControl.currentPage = 1;
    }
    else if(scrollView.contentOffset.x == self.imageScrollView.frame.size.width*2) {
        self.pageControl.currentPage = 2;
    }
      
}

- (void)setDetailData:(GOTalentDetailModel *)data
{
    //self.viewData = data;
}
- (IBAction)talentRegisterBtnTouched:(id)sender {
    [[GODataCenter2 sharedInstance] registerCreate:^(BOOL isSuccess, id responseData) {
        if(isSuccess)
        {
            NSLog(@"talentRegisterBtnTouched isSuccess: %lu", isSuccess);
            NSLog(@"talentRegisterBtnTouched responseData: %@", [responseData objectForKey:@"detail"]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"수업등록 성공" message:[responseData objectForKey:@"detail"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                
                
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            });
            
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"수업등록 실패" message:[responseData objectForKey:@"detail"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
                
                
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            });
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
