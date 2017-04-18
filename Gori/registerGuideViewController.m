//
//  registerGuideViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 16..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "registerGuideViewController.h"
#import "registerTalentFirstViewController.h"
#import "GODataCenter2.h"

@interface registerGuideViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tutorImage;
@end

@implementation registerGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.tutorImage.layer.masksToBounds = YES;
    self.tutorImage.layer.cornerRadius =  roundf(self.tutorImage.frame.size.width/2.0);;
    NSLog(@"tutorImgURL: %@", [GODataCenter2 sharedInstance].selectedModel.tutorImgURL);
    self.tutorImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[GODataCenter2 sharedInstance].selectedModel.tutorImgURL]];
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftBtnTouched:)];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //self.navigationItem.title = @"";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:232/255.0f green:45/255.0f blue:80/255.0f alpha:1.0f]}];
    


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftBtnTouched:(UIButton *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
        if([segue.identifier isEqualToString:@"registerFirstStep"]) {
            registerTalentFirstViewController *rgView = [segue destinationViewController];
            rgView.selectedModel = self.selectedModel;
            //NSLog(@"registerFirstStep: %@", rgView.selectedModel.title);
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
