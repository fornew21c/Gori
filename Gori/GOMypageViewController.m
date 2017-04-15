//
//  MypageViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 11..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOMypageViewController.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"

@interface GOMypageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *classListButton;
@property (weak, nonatomic) IBOutlet UIButton *wishListButton;
@property (weak, nonatomic) IBOutlet UIView *classListView;
@property (weak, nonatomic) IBOutlet UIView *wishListView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileEmailLabel;
@property (nonatomic, strong) NSMutableArray *pkMutableArray;

@end

@implementation GOMypageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [[GODataCenter sharedInstance]receiveServerUserDetailDataWithCompletionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *temp = [GODataCenter sharedInstance].networkUserDetailDictionary;
                NSLog(@"템프 딕셔너리의 데이터 : %@", temp);
                self.profileNameLabel.text = [temp objectForKey:@"name"];
                self.profileEmailLabel.text = [temp objectForKey:@"user_id"];
                NSLog(@"프로파일네임레이블 텍스트 : %@", [temp objectForKey:@"name"]);
                NSLog(@"프로파일이메일레이블 텍스트 : %@", [temp objectForKey:@"user_id"]);
                
                NSURL *profileURL = [NSURL URLWithString:[temp objectForKey:@"profile_image"]];
                self.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:profileURL]];
                NSLog(@"ReceivingServerData and ReloadingData is Completed");
                
            });
        }else{
              NSLog(@"ReceivingServerData and ReloadingData is Failed");
        }
    }];
    
    
    
    self.classListView.alpha = 1.0f;
    self.wishListView.alpha = 0.0f;
    
}

- (IBAction)signoutAction:(UIButton *)sender {
    [[GODataCenter2 sharedInstance] logoutCompletion:^(BOOL isSuccess, id respons) {
        if(isSuccess) {
            NSLog(@"로그아웃에 성공했습니다.");
        }
        else {
            NSLog(@"로그아웃에 실패했습니다.");

        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)goClassListView:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.classListView.alpha = 1.0f;
        self.wishListView.alpha = 0.0f;
    }];
}
- (IBAction)goWishListView:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.classListView.alpha = 0.0f;
        self.wishListView.alpha = 1.0f;
    }];
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
