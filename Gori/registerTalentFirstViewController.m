//
//  registerTalentFirstViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 16..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentFirstViewController.h"

@interface registerTalentFirstViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *locationButtonStackView;
@property NSMutableArray<UIButton *> *locationButtons;
@property (weak, nonatomic) IBOutlet UIButton *monBtn;
@property (weak, nonatomic) IBOutlet UIButton *tueBtn;
@property (weak, nonatomic) IBOutlet UIButton *wedBtn;
@property (weak, nonatomic) IBOutlet UIButton *thuBtn;
@property (weak, nonatomic) IBOutlet UIButton *friBtn;
@property (weak, nonatomic) IBOutlet UIButton *satBtn;
@property (weak, nonatomic) IBOutlet UIButton *sunBtn;


@end

@implementation registerTalentFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationItem.leftBarButtonItem = nil;
    //self.navigationItem.hidesBackButton = YES;
    
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(leftBtnTouched:)];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationItem.leftBarButtonItem.title = @"Back";
    NSLog(@"self.selectedModel.locations.count: %lu", self.selectedModel.locations.count);
    NSUInteger buttonWidth = self.locationButtonStackView.frame.size.width / self.selectedModel.locations.count;
    NSUInteger buttonHeight = self.locationButtonStackView.frame.size.height;
    for(NSUInteger i =0; i < self.selectedModel.locations.count; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight)];
        [self.locationButtonStackView addSubview:button];
        
        [button setTitle:[[self.selectedModel.locations objectAtIndex:i] objectForKey:@"region"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.333f alpha:1.0f] forState:UIControlStateHighlighted];
        //button.tintColor = [UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f];
        if(i == 0) {
            [button addTarget:self action:@selector(setDayButton) forControlEvents:UIControlEventTouchUpInside];
        }
        else if(i == 1) {
            [button addTarget:self action:@selector(setDayButton2) forControlEvents:UIControlEventTouchUpInside];
        }
        else if(i == 2) {
             [button addTarget:self action:@selector(setDayButton3) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.locationButtonStackView addSubview:button];
        
       // [[self.selectedModel.locations objectAtIndex:0] objectForKey:@"day"]
        
        //if([self.selectedModel.locations objectAtIndex:0] day)
    }
    [self buttonInit];

    //[self setDayButton];
    UIButton *button = [self.locationButtons objectAtIndex:0];
    [button addTarget:self action:@selector(setDayButton) forControlEvents:UIControlEventTouchUpInside];
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
    //darkGray:    [UIColor colorWithWhite:0.333f alpha:1.0f];
    //lightGray:   [UIColor colorWithWhite:0.667f alpha:1.0f];
    [self.monBtn setTitleColor:[UIColor colorWithWhite:0.333f alpha:1.0f] forState:UIControlStateNormal];
    [self.tueBtn setTitleColor:[UIColor colorWithWhite:0.333f alpha:1.0f] forState:UIControlStateNormal];
    [self.wedBtn setTitleColor:[UIColor colorWithWhite:0.333f alpha:1.0f] forState:UIControlStateNormal];
    [self.thuBtn setTitleColor:[UIColor colorWithWhite:0.333f alpha:1.0f] forState:UIControlStateNormal];
    [self.friBtn setTitleColor:[UIColor colorWithWhite:0.333f alpha:1.0f] forState:UIControlStateNormal];
    [self.satBtn setTitleColor:[UIColor colorWithWhite:0.333f alpha:1.0f] forState:UIControlStateNormal];
    [self.sunBtn setTitleColor:[UIColor colorWithWhite:0.333f alpha:1.0f] forState:UIControlStateNormal];
    
    self.monBtn.backgroundColor = [UIColor colorWithWhite:0.667f alpha:1.0f];
    self.tueBtn.backgroundColor = [UIColor colorWithWhite:0.667f alpha:1.0f];
    self.wedBtn.backgroundColor = [UIColor colorWithWhite:0.667f alpha:1.0f];
    self.thuBtn.backgroundColor = [UIColor colorWithWhite:0.667f alpha:1.0f];
    self.friBtn.backgroundColor = [UIColor colorWithWhite:0.667f alpha:1.0f];
    self.satBtn.backgroundColor = [UIColor colorWithWhite:0.667f alpha:1.0f];
    self.sunBtn.backgroundColor = [UIColor colorWithWhite:0.667f alpha:1.0f];
}
- (void)setDayButton
{
    //NSLog(@"%lu", sender.tag);
    [self buttonInit];
    NSLog(@"setDayButtonsetDayButton");
    NSLog(@"%@", [[self.selectedModel.regionsResult objectAtIndex:0] objectAtIndex:0]);
    for(NSUInteger i = 0; i < ((NSMutableArray*)[self.selectedModel.regionsResult objectAtIndex:0]).count; i++) {
    NSString *whatDay = [[[self.selectedModel.regionsResult objectAtIndex:0] objectAtIndex:i] objectForKey:@"day"];
        //NSLog(@"day: %@", [[[self.selectedModel.regionsResult objectAtIndex:0] objectForKey:@"region"] objectForKey:@"day"]);
        if([whatDay isEqualToString:@"일"]) {
            //self.sunBtn.backgroundColor = [UIColor whiteColor];
            [self.sunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.sunBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"월"]) {
            //self.monBtn.backgroundColor = [UIColor whiteColor];
            [self.monBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.monBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"화"]) {
            //self.tueBtn.backgroundColor = [UIColor whiteColor];
            [self.tueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.tueBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"수"]) {
            //self.wedBtn.backgroundColor = [UIColor whiteColor];
            [self.wedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.wedBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"목"]) {
            //self.thuBtn.backgroundColor = [UIColor whiteColor];
            [self.thuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.thuBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"금"]) {
            //self.friBtn.backgroundColor = [UIColor whiteColor];
            [self.friBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.friBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"토"]) {
            //self.satBtn.backgroundColor = [UIColor whiteColor];
            [self.satBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.satBtn.enabled = TRUE;
        }
    }
}


- (void)setDayButton2
{
    [self buttonInit];
    //NSLog(@"%lu", sender.tag);
    NSLog(@"setDayButtonsetDayButton");
    for(NSUInteger i = 0; i < ((NSMutableArray*)[self.selectedModel.regionsResult objectAtIndex:1]).count; i++) {
        NSString *whatDay = [[[self.selectedModel.regionsResult objectAtIndex:1] objectAtIndex:i] objectForKey:@"day"];
        if([whatDay isEqualToString:@"일"]) {
            //self.sunBtn.backgroundColor = [UIColor whiteColor];
            [self.sunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.sunBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"월"]) {
            //self.monBtn.backgroundColor = [UIColor whiteColor];
            [self.monBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.monBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"화"]) {
            //self.tueBtn.backgroundColor = [UIColor whiteColor];
            [self.tueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.tueBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"수"]) {
            //self.wedBtn.backgroundColor = [UIColor whiteColor];
            [self.wedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.wedBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"목"]) {
            //self.thuBtn.backgroundColor = [UIColor whiteColor];
            [self.thuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.thuBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"금"]) {
            //self.friBtn.backgroundColor = [UIColor whiteColor];
            [self.friBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.friBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"토"]) {
            //self.satBtn.backgroundColor = [UIColor whiteColor];
            [self.satBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.satBtn.enabled = TRUE;
        }
    }

}


- (void)setDayButton3
{
    [self buttonInit];
    //NSLog(@"%lu", sender.tag);
    NSLog(@"setDayButtonsetDayButton");
    for(NSUInteger i = 0; i < ((NSMutableArray*)[self.selectedModel.regionsResult objectAtIndex:2]).count; i++) {
        NSString *whatDay = [[[self.selectedModel.regionsResult objectAtIndex:2] objectAtIndex:i] objectForKey:@"day"];
        if([whatDay isEqualToString:@"일"]) {
            self.sunBtn.backgroundColor = [UIColor whiteColor];
            [self.sunBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.sunBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"월"]) {
            self.monBtn.backgroundColor = [UIColor whiteColor];
            [self.monBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.monBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"화"]) {
            self.tueBtn.backgroundColor = [UIColor whiteColor];
            [self.tueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.tueBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"수"]) {
            self.wedBtn.backgroundColor = [UIColor whiteColor];
            [self.wedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.wedBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"목"]) {
            self.thuBtn.backgroundColor = [UIColor whiteColor];
            [self.thuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.thuBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"금"]) {
            self.friBtn.backgroundColor = [UIColor whiteColor];
            [self.friBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.friBtn.enabled = TRUE;
        }
        else if([whatDay isEqualToString:@"토"]) {
            self.satBtn.backgroundColor = [UIColor whiteColor];
            [self.satBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.satBtn.enabled = TRUE;
        }
    }
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
