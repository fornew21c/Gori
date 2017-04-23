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
#import <SDWebImage/UIImageView+WebCache.h>

@interface GOUserInfoUpdateViewController ()
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

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
    
    ////////////////////////* settingTextFieldTag *//////////////////
    self.nameTextField.tag = 100;
    self.nameTextField.delegate = self;
    self.nickNameTextField.tag = 200;
    self.nickNameTextField.delegate = self;
    self.cellPhoneTextField.tag = 300;
    self.cellPhoneTextField.delegate = self;
    
    
    ////////////////////////* settingImagePickerController *//////////////////
    self.cameraController = [[UIImagePickerController alloc]init];
    self.cameraController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.cameraController.allowsEditing = NO;
    self.cameraController.delegate = self;
    
    self.updateUserPictureDataButton.layer.cornerRadius = 50;
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
        }else{
            
        }
    }];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.2);

    if (data.length >1000000) {
    }else{
        [[GODataCenter sharedInstance] updatingUserDetailImage:data completion:^(BOOL isSuccess, id respons) {
            if (isSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [picker dismissViewControllerAnimated:YES completion:nil];
                    [self.updateUserPictureDataButton setBackgroundImage:image forState:UIControlStateNormal];
                });
                
            }else{
                
            }
            
            
        }];
    }
    }

- (IBAction)uploadingUserImageAction:(UIButton *)sender {
    [self presentViewController:self.cameraController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [[GODataCenter sharedInstance]receiveServerUserDetailDataWithCompletionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *temp = [GODataCenter sharedInstance].networkUserDetailDictionary;
                NSURL *profileURL = [NSURL URLWithString:[temp objectForKey:@"profile_image"]];
                
                
                [self.updateUserPictureDataButton setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:profileURL]] forState:UIControlStateNormal];
            });
        }else{
            
        }
    }];
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view setFrame:CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == 100) {
        
        [self.nickNameTextField becomeFirstResponder];
        [self.cellPhoneTextField resignFirstResponder];
    }
    else if(textField.tag == 200) {
        [self.nameTextField resignFirstResponder];
        [self.cellPhoneTextField becomeFirstResponder];
    }else if (textField.tag == 300){
        [self.nameTextField resignFirstResponder];
        [self.nickNameTextField resignFirstResponder];
        [self.cellPhoneTextField resignFirstResponder];
        
    }

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
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
