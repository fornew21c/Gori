//
//  DetailViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 4..
//  Copyright © 2017년 fornew21c. All rights reserved.
//


//#define [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f] mainColor
#define PI 3.14
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]
#define darkGrayColor [UIColor colorWithWhite:0.333f alpha:1.0f]
#define lightGrayColor [UIColor colorWithWhite:0.667f alpha:1.0f]
#import "DetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "GODataCenter2.h"
#import "GOTalentDetailModel.h"
#import "registerGuideViewController.h"
#import "testViewController.h"


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
@property (weak, nonatomic) IBOutlet UILabel *curriculumLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *extraFee;
@property (weak, nonatomic) IBOutlet UIImageView *tutorImage2;
@property (weak, nonatomic) IBOutlet UILabel *locationMessage;

@property (weak, nonatomic) IBOutlet UIStackView *locationButtonStackView;
@property NSMutableArray<UIButton *> *locationButtons;
@property (weak, nonatomic) IBOutlet UIButton *monBtn;
@property (weak, nonatomic) IBOutlet UIButton *tueBtn;
@property (weak, nonatomic) IBOutlet UIButton *wedBtn;
@property (weak, nonatomic) IBOutlet UIButton *thuBtn;
@property (weak, nonatomic) IBOutlet UIButton *friBtn;
@property (weak, nonatomic) IBOutlet UIButton *satBtn;
@property (weak, nonatomic) IBOutlet UIButton *sunBtn;
@property (nonatomic) NSMutableArray<UIButton*> *canSelectButtons;
@property (nonatomic) NSMutableArray *selectedRegionResult;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GODataCenter2 sharedInstance].seletedRegionIndex = 0;
    [GODataCenter2 sharedInstance].seletedDayIndex = 0;
    
    // Do any additional setup after loading the view.
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.delegate = self;
   
    self.joinCntLabel.layer.masksToBounds = YES;
    self.joinCntLabel.layer.cornerRadius = 15;
    
    //self.tutorImage.clipsToBounds = YES;
    self.tutorImage.layer.masksToBounds = YES;
    self.tutorImage.layer.cornerRadius =  roundf(self.tutorImage.frame.size.width/2.0);;
  
    self.tutorImage2.layer.masksToBounds = YES;
    self.tutorImage2.layer.cornerRadius =  roundf(self.tutorImage2.frame.size.width/2.0);;
    [[GODataCenter2 sharedInstance] requestPostRetrieveID:self.pk completion:^(BOOL isSuccess, id responseData) {
        
        if(isSuccess)
        {
           // NSLog(@"isSuccess: %lu", isSuccess);
            //NSLog(@"title: %@", [responseData objectForKey:@"title"]);
            
            self.selectedModel = [GOTalentDetailModel modelWithData:responseData];
            [GODataCenter2 sharedInstance].selectedModel = self.selectedModel;
            NSLog(@"title: %@", [GODataCenter2 sharedInstance].selectedModel.title);
            NSLog(@"region: %@", [GODataCenter2 sharedInstance].selectedModel.region);
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
    NSString *tmpRegion = @"";

    for(NSUInteger i = 0; i < self.selectedModel.locations.count; i++) {
        
        tmpRegion = [[tmpRegion stringByAppendingString:[self.selectedModel.region objectAtIndex:i]] stringByAppendingString:@" "];
    }
    self.talentRegion.text =  tmpRegion;
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
    
    //커리큘럼
    if(self.selectedModel.curriculums.count != 0) {
        self.curriculumLabel.text = [[self.selectedModel.curriculums objectAtIndex:0] objectForKey:@"information"];
    }
    
    //위치/요일 정보
    NSLog(@"self.selectedModel.locations.count: %lu", self.selectedModel.locations.count);
    NSUInteger buttonWidth = self.locationButtonStackView.frame.size.width / self.selectedModel.locations.count;
    NSUInteger buttonHeight = self.locationButtonStackView.frame.size.height;
    self.locationButtons = [[NSMutableArray alloc] init];
    for(NSUInteger i =0; i < self.selectedModel.locations.count; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight)];
        [self.locationButtonStackView addSubview:button];
        
        [button setTitle:[[self.selectedModel.locations objectAtIndex:i] objectForKey:@"region"] forState:UIControlStateNormal];

        if(i == 0) {
            [button setTitleColor:mainColor forState:UIControlStateNormal];
        }
        else {
            [button setTitleColor:lightGrayColor forState:UIControlStateNormal];
        }
 
        button.tag = i;
        [self.locationButtons addObject:button];
        [button addTarget:self action:@selector(setDayButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.locationButtonStackView addSubview:button];
    }
    NSLog(@"layoutDataInView self.locationButtons.count: %lu", self.locationButtons.count);
    [self buttonInit];
    [self setDefaultDayButton];
    self.tutorImage2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.selectedModel.tutorImgURL]];
    self.locationMessage.text = self.selectedModel.locationMessage;
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

- (void)buttonInit
{
    self.monBtn.enabled = NO;
    self.tueBtn.enabled = NO;
    self.wedBtn.enabled = NO;
    self.thuBtn.enabled = NO;
    self.friBtn.enabled = NO;
    self.satBtn.enabled = NO;
    self.sunBtn.enabled = NO;

    [self.monBtn setTitleColor:lightGrayColor forState:UIControlStateNormal];
    [self.tueBtn setTitleColor:lightGrayColor forState:UIControlStateNormal];
    [self.wedBtn setTitleColor:lightGrayColor forState:UIControlStateNormal];
    [self.thuBtn setTitleColor:lightGrayColor forState:UIControlStateNormal];
    [self.friBtn setTitleColor:lightGrayColor forState:UIControlStateNormal];
    [self.satBtn setTitleColor:lightGrayColor forState:UIControlStateNormal];
    [self.sunBtn setTitleColor:lightGrayColor forState:UIControlStateNormal];
    
    self.monBtn.backgroundColor = mainColor;
    self.tueBtn.backgroundColor = mainColor;
    self.wedBtn.backgroundColor = mainColor;
    self.thuBtn.backgroundColor = mainColor;
    self.friBtn.backgroundColor = mainColor;
    self.satBtn.backgroundColor = mainColor;
    self.sunBtn.backgroundColor = mainColor;
}


- (void)setDefaultDayButton{
    
    [self buttonInit];
    NSLog(@"setDayButtonsetDayButton");
    self.canSelectButtons = [[NSMutableArray alloc] init];
    self.selectedRegionResult = [self.selectedModel.regionsResult objectAtIndex:0];
    [GODataCenter2 sharedInstance].locationPK = [[[self.selectedRegionResult objectAtIndex:0] objectForKey:@"pk" ] integerValue]; //아무것도 선택안하고 갈경우 default location pk 지정
    for(NSUInteger i = 0; i < ((NSMutableArray*)[self.selectedModel.regionsResult objectAtIndex:0]).count; i++) {
        NSString *whatDay = [[[self.selectedModel.regionsResult objectAtIndex:0] objectAtIndex:i] objectForKey:@"day"];
        //NSLog(@"day: %@", [[[self.selectedModel.regionsResult objectAtIndex:0] objectForKey:@"region"] objectForKey:@"day"]);

        if([whatDay isEqualToString:@"월"]) {
            //self.monBtn.backgroundColor = [UIColor whiteColor];
            [self.monBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.monBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.monBtn];
            
        }
        else if([whatDay isEqualToString:@"화"]) {
            //self.tueBtn.backgroundColor = [UIColor whiteColor];
            [self.tueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.tueBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.tueBtn];
            
        }
        else if([whatDay isEqualToString:@"수"]) {
            //self.wedBtn.backgroundColor = [UIColor whiteColor];
            [self.wedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.wedBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.wedBtn];
            
        }
        else if([whatDay isEqualToString:@"목"]) {
            //self.thuBtn.backgroundColor = [UIColor whiteColor];
            [self.thuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.thuBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.thuBtn];
        }
        else if([whatDay isEqualToString:@"금"]) {
            //self.friBtn.backgroundColor = [UIColor whiteColor];
            [self.friBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.friBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.friBtn];
            
        }
        else if([whatDay isEqualToString:@"토"]) {
            //self.satBtn.backgroundColor = [UIColor whiteColor];
            [self.satBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.satBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.satBtn];
        }
        else if([whatDay isEqualToString:@"일"]) {
            //self.sunBtn.backgroundColor = [UIColor whiteColor];
            [self.sunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.sunBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.sunBtn];
        }
    }
    for(NSUInteger i = 0; i < self.canSelectButtons.count; i++) {
        [self.canSelectButtons objectAtIndex:i].tag = i;
        [[self.canSelectButtons objectAtIndex:i] addTarget:self action:@selector(dayButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.canSelectButtons objectAtIndex:0].backgroundColor = [UIColor whiteColor];
    
    NSLog(@"time: %@", [[[self.selectedModel.regionsResult objectAtIndex:0] objectAtIndex:0] objectForKey:@"time" ]);
    NSMutableArray *times = [[[self.selectedModel.regionsResult objectAtIndex:0] objectAtIndex:0] objectForKey:@"time" ];
    NSString *timeStr = @"";
    for(NSUInteger i = 0; i < times.count; i++) {
        timeStr = [[timeStr stringByAppendingString:[times objectAtIndex:i]] stringByAppendingString:@" "];
    }
    self.time.text = timeStr;
    self.extraFee.text = [[[self.selectedModel.regionsResult objectAtIndex:0] objectAtIndex:0] objectForKey:@"extra_fee_amount" ];
}

- (void)setDayButton:(UIButton*)sender
{
    [self buttonInit];
    NSLog(@"setDayButton: %lu", sender.tag);
    //    if(sender.selected) {
    //        [sender setSelected:NO];
    //        [sender setTitleColor:mainColor forState:UIControlStateNormal];
    //    }
    //    else {
    //        [sender setSelected:YES];
    //        [sender setTitleColor:lightGrayColor forState:UIControlStateNormal];
    //    }
    self.selectedRegionResult = [self.selectedModel.regionsResult objectAtIndex:sender.tag];
    [GODataCenter2 sharedInstance].locationPK = [[[self.selectedRegionResult objectAtIndex:0] objectForKey:@"pk" ] integerValue]; //지역만 선택한 경우 locationPK에 지역의 첫번째 요일의 locationPK 세팅
    [GODataCenter2 sharedInstance].locationSelectedBefore = YES;
    [GODataCenter2 sharedInstance].seletedRegionIndex = sender.tag;
    NSLog(@"selectedRegionResult: %@", self.selectedRegionResult);
    self.canSelectButtons = [[NSMutableArray alloc] init];
    for(NSUInteger i = 0; i < self.locationButtons.count; i++) {
        if(i == sender.tag) {
            [[self.locationButtons objectAtIndex:i] setTitleColor:mainColor forState:UIControlStateNormal];
        }
        else {
            [[self.locationButtons objectAtIndex:i] setTitleColor:lightGrayColor forState:UIControlStateNormal];
        }
    }
    
    self.canSelectButtons = [[NSMutableArray alloc] init];
    for(NSUInteger i = 0; i < ((NSMutableArray*)[self.selectedModel.regionsResult objectAtIndex:sender.tag]).count; i++) {
        NSString *whatDay = [[[self.selectedModel.regionsResult objectAtIndex:sender.tag] objectAtIndex:i] objectForKey:@"day"];
        if([whatDay isEqualToString:@"월"]) {
            //self.monBtn.backgroundColor = [UIColor whiteColor];
            [self.monBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.monBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.monBtn];
            
        }
        else if([whatDay isEqualToString:@"화"]) {
            //self.tueBtn.backgroundColor = [UIColor whiteColor];
            [self.tueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.tueBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.tueBtn];
            
        }
        else if([whatDay isEqualToString:@"수"]) {
            //self.wedBtn.backgroundColor = [UIColor whiteColor];
            [self.wedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.wedBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.wedBtn];
            
        }
        else if([whatDay isEqualToString:@"목"]) {
            //self.thuBtn.backgroundColor = [UIColor whiteColor];
            [self.thuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.thuBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.thuBtn];
        }
        else if([whatDay isEqualToString:@"금"]) {
            //self.friBtn.backgroundColor = [UIColor whiteColor];
            [self.friBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.friBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.friBtn];
            
        }
        else if([whatDay isEqualToString:@"토"]) {
            //self.satBtn.backgroundColor = [UIColor whiteColor];
            [self.satBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.satBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.satBtn];
        }
        else if([whatDay isEqualToString:@"일"]) {
            //self.sunBtn.backgroundColor = [UIColor whiteColor];
            [self.sunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.sunBtn.enabled = TRUE;
            [self.canSelectButtons addObject:self.sunBtn];
        }
    }
    for(NSUInteger i = 0; i < self.canSelectButtons.count; i++) {
        [self.canSelectButtons objectAtIndex:i].tag = i;
        [[self.canSelectButtons objectAtIndex:i] addTarget:self action:@selector(dayButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSMutableArray *times = [[self.selectedRegionResult objectAtIndex:0] objectForKey:@"time" ];
    NSString *timeStr = @"";
    for(NSUInteger i = 0; i < times.count; i++) {
        timeStr = [[timeStr stringByAppendingString:[times objectAtIndex:i]] stringByAppendingString:@" "];
    }
    self.time.text = timeStr;
    [self.canSelectButtons objectAtIndex:0].backgroundColor = [UIColor whiteColor];
}

- (void)dayButtonTouched:(UIButton*)sender
{
    NSLog(@"dayButtonTouched sender.tag: %lu", sender.tag);
    for(NSUInteger i = 0; i < self.canSelectButtons.count; i++) {
        if(i == sender.tag) {
            [self.canSelectButtons objectAtIndex:i].backgroundColor = [UIColor whiteColor];
        }
        else {
            [self.canSelectButtons objectAtIndex:i].backgroundColor = mainColor;
        }
    }
    NSMutableArray *times = [[self.selectedRegionResult objectAtIndex:sender.tag] objectForKey:@"time" ];
    NSString *timeStr = @"";
    for(NSUInteger i = 0; i < times.count; i++) {
        timeStr = [[timeStr stringByAppendingString:[times objectAtIndex:i]] stringByAppendingString:@" "];
    }
    self.time.text = timeStr;
    [GODataCenter2 sharedInstance].locationPK = [[[self.selectedRegionResult objectAtIndex:sender.tag] objectForKey:@"pk" ] integerValue];
    [GODataCenter2 sharedInstance].locationSelectedBefore = YES;
    [GODataCenter2 sharedInstance].seletedDayIndex = sender.tag;
    NSLog(@"region pk: %lu", [GODataCenter2 sharedInstance].locationPK );
    //self.time.text = [[self.selectedRegionResult objectAtIndex:sender.tag] objectForKey:@"time"];
}


- (IBAction)talentRegisterBtnTouched:(id)sender {
    // [self performSegueWithIdentifier:@"testSegue" sender:sender];
    NSLog(@"region pk: %lu", [GODataCenter2 sharedInstance].locationPK );

    [self performSegueWithIdentifier:@"registerSegue" sender:sender];
 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"registerSegue"]) {
        registerGuideViewController *rgView = [segue destinationViewController];
        rgView.selectedModel = self.selectedModel;
    }
    else if([[segue identifier] isEqualToString:@"testSegue"]) {
        testViewController *testView = [segue destinationViewController];
        testView.recivedData = self.selectedModel.title;
        
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
