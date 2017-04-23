//
//  GOQAViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 22..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOQAViewController.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"
#import "DetailViewController.h"

@interface GOQAViewController ()
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *QAInputTextFieldView;
@property (weak, nonatomic) IBOutlet UITextField *QAInputTextField;
@property (weak, nonatomic) IBOutlet UIButton *QAInputTextFteldButton;



@end

@implementation GOQAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addingKeyboardObserverShow];
    [self addingKeyboardObserverHide];
    
}
- (IBAction)uploadingQAText:(UIButton *)sender {
    
    NSInteger userPKInteger = [GODataCenter2 sharedInstance].selectedModel.postID;
    NSString *userQuestionString = self.QAInputTextField.text;
    
    [[GODataCenter sharedInstance]updatingUserQuestionText:userQuestionString talentPK:userPKInteger completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.QAInputTextField resignFirstResponder];
                [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
            });
        }else{
            UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"OOPS!" message:@"네트워크 연결 상태를 확인하세요" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirm= [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:nil];
            [networkAlert addAction:confirm];
            [self presentViewController:networkAlert animated:nil completion:nil];
        }
    }];
}


- (void)addingKeyboardObserverShow{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShowKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)didShowKeyboardNotification:(NSNotification *)sender{
    
    CGFloat keyboardHeight = [[sender.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    [self.QAInputTextFieldView setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - keyboardHeight - (self.QAInputTextFieldView.frame.size.height / 2))];
    }

- (void)addingKeyboardObserverHide{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHideKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) didHideKeyboardNotification:(NSNotification *)sender{
    
    [self.QAInputTextFieldView setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - (self.QAInputTextFieldView.frame.size.height / 2))];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
