//
//  GOUserInfoUpdateViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 16..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOUserInfoUpdateViewController.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"
#import "NetworkModuleMain.h"

@interface GOUserInfoUpdateViewController ()
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cellPhoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *updateUserTextDataButton;
@property (weak, nonatomic) IBOutlet UIButton *updateUserPictureDataButton;
@property (nonatomic) IBOutlet UIImageView *imageView1;
@property (nonatomic) UIImagePickerController *cameraController;


@end

@implementation GOUserInfoUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ////////////////////////* settingImagePickerController *//////////////////
    self.cameraController = [[UIImagePickerController alloc]init];
    self.cameraController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.cameraController.allowsEditing = NO;
    self.cameraController.delegate = self;
    
    self.updateUserPictureDataButton.layer.cornerRadius = 30;
    self.updateUserPictureDataButton.layer.masksToBounds = YES;
    self.updateUserPictureDataButton.clipsToBounds = YES;
    
}
- (IBAction)updateUserTextDataAction:(UIButton *)sender {
    [[GODataCenter2 sharedInstance]getMyLoginToken];
    NSString *nameString = [NSString stringWithFormat:@"%@", self.nameTextField.text];
    NSString *nickNameString = [NSString stringWithFormat:@"%@", self.nickNameTextField.text];
    NSString *cellPhoneString = [NSString stringWithFormat:@"%@", self.cellPhoneTextField.text];
    
    [[GODataCenter sharedInstance]updatingUserDetailText:nameString nickName:nickNameString cellPhone:cellPhoneString completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
            NSLog(@"유제인포뷰컨트롤러 버튼 Success");
        }else{
            NSLog(@"유제인포뷰컨트롤러 버튼 눌렸으나 다음으로 안넘어감");
            nil;
        }
    }];
//    NSLog(@"유저인포컨트롤러 스트링 체크 : %@ / %@ / %@",nameString, nickNameString, cellPhoneString);
//    NSLog(@"유제인포뷰컨트롤러 버튼 눌림");
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/////////////////////*이미지 피커 컨트롤러 델리게이트의 작성 */////////////////////////

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.2);

//    if(data.length >)...사진 용량에 대한 분기를 나눠야 함...용량이 2mb 정도 수준임...
    if (data.length >1000000) {
        NSLog(@"이미지가 너무 큼");
        NSLog(@"data length : %lu", data.length);
    }else{
        [[GODataCenter sharedInstance] updatingUserDetailImage:data completion:^(BOOL isSuccess, id respons) {
            if (isSuccess) {
                NSLog(@"유저인포컨트롤러 이미지피커 활성화");
                
            }else{
                NSLog(@"유저인포컨트롤러 이미지피커 활성화 안됨");
            }
            
            [self.updateUserPictureDataButton setBackgroundImage:image forState:UIControlStateNormal];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        //    NSString *name = @"UploadedImage.png";

    }
    
    
    }
- (IBAction)uploadingUserImageAction:(UIButton *)sender {
    [self presentViewController:self.cameraController animated:YES completion:nil];
}

//이미지를 선택을 취소하고서 알아서 dismiss되도록 설정해 줘야 함
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [[GODataCenter sharedInstance]receiveServerUserDetailDataWithCompletionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *temp = [GODataCenter sharedInstance].networkUserDetailDictionary;
                //                NSLog(@"템프 딕셔너리의 데이터 : %@", temp);
//                self.profileNameLabel.text = [temp objectForKey:@"name"];
//                self.profileEmailLabel.text = [temp objectForKey:@"user_id"];
//                self.profileNickNameLabel.text = [temp objectForKey:@"nickname"];
                //                NSLog(@"프로파일네임레이블 텍스트 : %@", [temp objectForKey:@"name"]);
                //                NSLog(@"프로파일이메일레이블 텍스트 : %@", [temp objectForKey:@"user_id"]);
                
                NSURL *profileURL = [NSURL URLWithString:[temp objectForKey:@"profile_image"]];
                [self.updateUserPictureDataButton setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:profileURL]] forState:UIControlStateNormal];
                NSLog(@"ReceivingServerData and ReloadingData is Completed");
                
            });
        }else{
            NSLog(@"ReceivingServerData and ReloadingData is Failed");
        }
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
