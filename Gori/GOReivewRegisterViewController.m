//
//  GOReivewRegisterViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 22..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOReivewRegisterViewController.h"
#import "GOReviewTableViewCell.h"
#import "GODataCenter2.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface GOReivewRegisterViewController ()
<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet HCSStarRatingView *curriculumRate;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *redinessRate;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *timelinessRate;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *deliveryRate;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *friendlinessRate;
@property  UILabel *placeholerLabel;
@property (strong, nonatomic) IBOutlet UIView *contentsView;

@property (weak, nonatomic) IBOutlet UITextView *reviewComment;

@end

@implementation GOReivewRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,70,70)];
    titleLabel.font = [UIFont systemFontOfSize:17.0f];
    titleLabel.text = @"리뷰 등록";
    self.navigationItem.titleView = titleLabel;
    
    self.reviewComment.layer.borderWidth = 1;
    self.reviewComment.layer.cornerRadius = 5;
    self.placeholerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0,self.reviewComment.frame.size.width - 10.0, self.reviewComment.frame.size.height/3)];
    
    self.placeholerLabel.numberOfLines = 3;
    NSString *tmpStr = @"수업에 리뷰를 남겨주세요";
    NSString *tmpStr2 = @"수강생분의 리뷰 하나가 튜터님의 강의 발전에";
    NSString *tmpStr3 = @"큰 보탬이 됩니다.";
    NSString *placeHolderStr = [[[[tmpStr stringByAppendingString:@"\n"] stringByAppendingString:tmpStr2] stringByAppendingString:@"\n"] stringByAppendingString:tmpStr3];
    
    [self.placeholerLabel setText:placeHolderStr];
    [self.placeholerLabel setBackgroundColor:[UIColor clearColor]];
    [self.placeholerLabel setTextColor:[UIColor lightGrayColor]];
    self.reviewComment.delegate = self;
    
    [self.reviewComment addSubview:self.placeholerLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //화면 내리기
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect=self.view.frame;
    rect.origin.y-=250;
    rect.size.height+=250;
    self.view.frame=rect;
    [UIView commitAnimations];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (![self.reviewComment hasText]) {
        self.placeholerLabel.hidden = NO;
    }
    [textView resignFirstResponder];//키보드 없애기
    //화면 내리기
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect=self.view.frame;
    rect.origin.y+=250;
    rect.size.height-=250;
    self.view.frame=rect;
    [UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void) textViewDidChange:(UITextView *)textView
{
    if(![self.reviewComment  hasText]) {
        self.placeholerLabel.hidden = NO;
    }
    else{
        self.placeholerLabel.hidden = YES;
    }
}
- (IBAction)reviewRegisterBtnTouched:(id)sender {
    NSUInteger pk = [GODataCenter2 sharedInstance].selectedModel.postID;
    NSUInteger curriculum = (NSUInteger)self.curriculumRate.value;
    NSUInteger readiness = (NSUInteger)self.redinessRate.value;
    NSUInteger timeliness = (NSUInteger)self.timelinessRate.value;
    NSUInteger delivery = (NSUInteger)self.deliveryRate.value;
    NSUInteger friendliness = (NSUInteger)self.friendlinessRate.value;
    NSString *comment = self.reviewComment.text;
    [[GODataCenter2 sharedInstance] registerReviewWithPK:pk
                                              curriculum:curriculum
                                               readiness:readiness
                                              timeliness:timeliness
                                                delivery:delivery
                                            friendliness:friendliness
                                                 comment:comment
      completion:^(BOOL isSuccess, id responseData) {
          if(isSuccess)
          {
              NSLog(@"%@", [responseData objectForKey:@"detail"]);
              dispatch_async(dispatch_get_main_queue(), ^{
                  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"리뷰등록 성공" message:[responseData objectForKey:@"detail"]preferredStyle:UIAlertControllerStyleAlert];
                  
                  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                      [self.navigationController popViewControllerAnimated:YES];
                  }];
                  
                  
                  [alertController addAction:okAction];
                  [self presentViewController:alertController animated:YES completion:nil];
              });
              
          }else
          {
              NSLog(@"%@", [responseData objectForKey:@"detail"]);
              dispatch_async(dispatch_get_main_queue(), ^{
                  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"리뷰등록 실패" message:[responseData objectForKey:@"detail"]preferredStyle:UIAlertControllerStyleAlert];
                  
                  UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                      [self.navigationController popViewControllerAnimated:YES];
                  }];
                  
                  
                  [alertController addAction:okAction];
                  [self presentViewController:alertController animated:YES completion:nil];
              });
              
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
