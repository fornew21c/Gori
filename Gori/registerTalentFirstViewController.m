//
//  registerTalentFirstViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 16..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentFirstViewController.h"
#import "GODataCenter2.h"
#define mainColor [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]
#define darkGrayColor [UIColor colorWithWhite:0.333f alpha:1.0f]
#define lightGrayColor [UIColor colorWithWhite:0.667f alpha:1.0f]

@interface registerTalentFirstViewController ()

@property (nonatomic) NSMutableArray<UIButton*> *canSelectButtons;
@property (nonatomic) NSMutableArray *selectedRegionResult;

@property (weak, nonatomic) IBOutlet UIStackView *locationButtonStackView;
@property NSMutableArray<UIButton *> *locationButtons;
@property (weak, nonatomic) IBOutlet UIButton *monBtn;
@property (weak, nonatomic) IBOutlet UIButton *tueBtn;
@property (weak, nonatomic) IBOutlet UIButton *wedBtn;
@property (weak, nonatomic) IBOutlet UIButton *thuBtn;
@property (weak, nonatomic) IBOutlet UIButton *friBtn;
@property (weak, nonatomic) IBOutlet UIButton *satBtn;
@property (weak, nonatomic) IBOutlet UIButton *sunBtn;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *extraFee;
@property (weak, nonatomic) IBOutlet UIImageView *tutorImage3;


@end

@implementation registerTalentFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tutorImage3.layer.masksToBounds = YES;
    self.tutorImage3.layer.cornerRadius =  roundf(self.tutorImage3.frame.size.width/2.0);;
   
    self.tutorImage3.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.selectedModel.tutorImgURL]];
    NSLog(@"self.selectedModel.locations.count: %lu", self.selectedModel.locations.count);
    NSUInteger buttonWidth = self.locationButtonStackView.frame.size.width / self.selectedModel.locations.count;
    NSUInteger buttonHeight = self.locationButtonStackView.frame.size.height;
    self.locationButtons = [[NSMutableArray alloc] init];
    for(NSUInteger i =0; i < self.selectedModel.locations.count; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight)];
        [self.locationButtonStackView addSubview:button];
        
        [button setTitle:[[self.selectedModel.locations objectAtIndex:i] objectForKey:@"region"] forState:UIControlStateNormal];
        
        if(i == [GODataCenter2 sharedInstance].seletedRegionIndex) {
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
    NSLog(@"viewDidLoad self.locationButtons.count: %lu", self.locationButtons.count);
    [self buttonInit];
    [self setDefaultDayButton];
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
    self.selectedRegionResult = [self.selectedModel.regionsResult objectAtIndex:[GODataCenter2 sharedInstance].seletedRegionIndex];
    [GODataCenter2 sharedInstance].locationPK = [[[self.selectedRegionResult objectAtIndex:[GODataCenter2 sharedInstance].seletedRegionIndex] objectForKey:@"pk" ] integerValue]; //아무것도 선택안하고 갈경우 default location pk 지정
    for(NSUInteger i = 0; i < ((NSMutableArray*)[self.selectedModel.regionsResult objectAtIndex:0]).count; i++) {
        NSString *whatDay = [[[self.selectedModel.regionsResult objectAtIndex:[GODataCenter2 sharedInstance].seletedRegionIndex] objectAtIndex:i] objectForKey:@"day"];
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
    [self.canSelectButtons objectAtIndex:[GODataCenter2 sharedInstance].seletedDayIndex].backgroundColor = [UIColor whiteColor];
    
    NSLog(@"time: %@", [[[self.selectedModel.regionsResult objectAtIndex:[GODataCenter2 sharedInstance].seletedRegionIndex] objectAtIndex:[GODataCenter2 sharedInstance].seletedDayIndex] objectForKey:@"time" ]);
    NSMutableArray *times = [[[self.selectedModel.regionsResult objectAtIndex:[GODataCenter2 sharedInstance].seletedRegionIndex] objectAtIndex:[GODataCenter2 sharedInstance].seletedDayIndex] objectForKey:@"time" ];
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
    NSLog(@"selectedRegionResult: %@", self.selectedRegionResult);
     NSLog(@"self.locationButtons.count: %lu", self.selectedModel.locations.count);
    
    for(NSUInteger i = 0; i < self.selectedModel.locations.count; i++) {
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
    NSLog(@"region pk: %lu", [GODataCenter2 sharedInstance].locationPK );
    //self.time.text = [[self.selectedRegionResult objectAtIndex:sender.tag] objectForKey:@"time"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftBtnTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
