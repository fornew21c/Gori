//
//  registerTalentSecondViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 16..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerTalentSecondViewController.h"
#import "GODataCenter2.h"

@interface registerTalentSecondViewController ()
<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *experienceView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *studentLevel;
@property (weak, nonatomic) IBOutlet UITextField *studentExperienceMonth;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *tutorImage5;
 

@property (weak, nonatomic) IBOutlet UITextView *messageToTutor;
@property  UILabel *placeholerLabel;

@end

@implementation registerTalentSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tutorImage5.layer.masksToBounds = YES;
    self.tutorImage5.layer.cornerRadius =  roundf(self.tutorImage5.frame.size.width/2.0);;
    self.tutorImage5.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[GODataCenter2 sharedInstance].selectedModel.tutorImgURL]];
    
    [GODataCenter2 sharedInstance].studentLevel = 1;
    // Do any additional setup after loading the view.
    self.experienceView.layer.borderWidth = 1;
    self.experienceView.layer.borderColor = [UIColor darkGrayColor].CGColor;
   // self.experienceView.layer.masksToBounds = 5;
    self.experienceView.layer.cornerRadius = 5;
    self.studentExperienceMonth.delegate = self;
    self.messageToTutor.layer.borderWidth = 1;
    self.messageToTutor.layer.cornerRadius = 5;
    self.placeholerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0,self.messageToTutor.frame.size.width - 10.0, self.messageToTutor.frame.size.height)];
    
    self.placeholerLabel.numberOfLines = 3;
    NSString *tmpStr = @"튜터님에게 알려주세요";
    NSString *tmpStr2 = @"수업을 듣는 목적은 무엇인가요?";
    NSString *tmpStr3 = @"튜터팀의 어떤 점이 마음에 들어 신청하였나요?";
    NSString *placeHolderStr = [[[[tmpStr stringByAppendingString:@"\n"] stringByAppendingString:tmpStr2] stringByAppendingString:@"\n"] stringByAppendingString:tmpStr3];
    
    [self.placeholerLabel setText:placeHolderStr];
    [self.placeholerLabel setBackgroundColor:[UIColor clearColor]];
    [self.placeholerLabel setTextColor:[UIColor lightGrayColor]];
    self.messageToTutor.delegate = self;
    
    [self.messageToTutor addSubview:self.placeholerLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)studentLevelChanged:(id)sender {
    NSLog(@"self.studentLevel.selectedSegmentIndex: %ld", self.studentLevel.selectedSegmentIndex);
    [GODataCenter2 sharedInstance].studentLevel = self.studentLevel.selectedSegmentIndex + 1;
    
    //segment.selectedSegmentIndex
}

- (void)textViewDidEndEditing:(UITextView *)theTextView
{
    if (![self.messageToTutor hasText]) {
        self.placeholerLabel.hidden = NO;
    }
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}

- (void) textViewDidChange:(UITextView *)textView
{
    if(![self.messageToTutor  hasText]) {
        self.placeholerLabel.hidden = NO;
    }
    else{
        self.placeholerLabel.hidden = YES;
    }  
}
- (IBAction)nextBtnTouched:(id)sender {
    if( [self.studentExperienceMonth.text isEqualToString:@""]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"알림" message:@"경력을 입력하세요." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
    else if( [self.messageToTutor.text isEqualToString:@""]) {
     
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"알림" message:@"요청사항을 입력하세요." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
      
    }
    else {
        [GODataCenter2 sharedInstance].experienceMonth = [self.studentExperienceMonth.text integerValue];
        [GODataCenter2 sharedInstance].messageToTutor =  self.messageToTutor.text;
        [self performSegueWithIdentifier:@"registerThirdStep" sender:nil];
    }
}

//- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
   // if(textField.tag == 2) {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    //}
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textViewDidBeginEditing");
    [self.scrollView setContentOffset:CGPointMake(0, 300) animated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
  
    return YES;
}


@end
