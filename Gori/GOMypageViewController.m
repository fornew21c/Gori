//
//  MypageViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 11..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOMypageViewController.h"
#import "GODataCenter.h"

@interface GOMypageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registrationButton;
@property (weak, nonatomic) IBOutlet UIButton *classListButton;
@property (weak, nonatomic) IBOutlet UIButton *wishListButton;
@property (weak, nonatomic) IBOutlet UIView *registrationView;
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
    
    /**************** userProfile and pk Setting ********************************/
//    
//    [[GODataCenter sharedInstance]receiveServerDataWithCompletionBlock:^(BOOL isSuccess) {
//        if (isSuccess) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSDictionary *temp = [[NSDictionary alloc]init];
//                NSMutableArray *tutorMutableArray = [[NSMutableArray alloc]init];
//                NSMutableArray *titleMutableArray = [[NSMutableArray alloc]init];
//                NSMutableArray *pkMutableArray = [[NSMutableArray alloc]init];
//                for (NSInteger i = 0; i < [GODataCenter sharedInstance].networkDataArray.count; i++) {
//                    temp = [[GODataCenter sharedInstance].networkDataArray objectAtIndex:i];
//                    [tutorMutableArray addObject:[[temp objectForKey:@"tutor"] objectForKey:@"name"]];
//                    [titleMutableArray addObject:[temp objectForKey:@"title"]];
//                    [pkMutableArray addObject:[temp objectForKey:@"pk"]];
//                }
//                self.pkMutableArray = pkMutableArray;
//                self.tutorNameMutableArray = tutorMutableArray;
//                self.titleNameMutableArray = titleMutableArray;
//                
//                NSLog(@" pk array data : %@", self.pkMutableArray);
//                self.searchDataSetTutorName = [[NSArray alloc]initWithArray:self.tutorNameMutableArray];
//                self.searchDataSetTitleName = [[NSArray alloc]initWithArray:self.titleNameMutableArray];
//                NSLog(@"ReceivingServerData and ReloadingData is Completed");
//            });
//        }else{
//            NSLog(@"ReceivingServerData and ReloadingData is Failed");
//        }
//    }];
//
    [[GODataCenter sharedInstance]receiveServerUserDetailDataWithCompletionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *temp = [GODataCenter sharedInstance].networkUserDetailDictionary;
                NSLog(@"템프 딕셔너리의 데이터 : %@", temp);
                self.profileNameLabel.text = [temp objectForKey:@"name"];
                self.profileEmailLabel.text = [temp objectForKey:@"user_id"];
                
                NSURL *profileURL = [NSURL URLWithString:[temp objectForKey:@"profile_image"]];
                self.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:profileURL]];
                NSLog(@"ReceivingServerData and ReloadingData is Completed");
            });
        }else{
              NSLog(@"ReceivingServerData and ReloadingData is Failed");
        }
    }];
    /**************** 토큰값을 임의로 지정한 결과 잘 됨...토큰을 어떻게 다른곳에 저장시키고 불러와야 할 지가 문제임**********/
    
    
    self.registrationView.alpha = 1.0f;
    self.classListView.alpha = 0.0f;
    self.wishListView.alpha = 0.0f;
    
}
- (IBAction)goRegistrationView:(UIButton *)sender {
    [UIView animateWithDuration:1.5 animations:^{
        self.registrationView.alpha = 1.0f;
        self.classListView.alpha = 0.0f;
        self.wishListView.alpha = 0.0f;
    }];
    
}
- (IBAction)goClassListView:(UIButton *)sender {
    [UIView animateWithDuration:1.5 animations:^{
        self.registrationView.alpha = 0.0f;
        self.classListView.alpha = 1.0f;
        self.wishListView.alpha = 0.0f;
    }];
}
- (IBAction)goWishListView:(UIButton *)sender {
    [UIView animateWithDuration:1.5 animations:^{
        self.registrationView.alpha = 0.0f;
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
