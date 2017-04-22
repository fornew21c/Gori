//
//  GOReviewViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 22..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOReviewViewController.h"
#import "GODataCenter2.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface GOReviewViewController ()
@property (weak, nonatomic) IBOutlet HCSStarRatingView *curriculumReview;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *readinessReview;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *timelinessReview;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *deliveryReview;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *friendlinessReview;

@end

@implementation GOReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.curriculumReview.value =
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
