//
//  DetailViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 4..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "DetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "GODataCenter2.h"
#import "TalentDetailModel.h"

@interface DetailViewController ()
<UIScrollViewDelegate>
@property (nonatomic, strong) TalentDetailModel *viewData;

@property (weak, nonatomic) IBOutlet UILabel *talentRegion;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *hoursPerClass;
@property (weak, nonatomic) IBOutlet UILabel *joinCntLabel;
@property (weak, nonatomic) IBOutlet UILabel *talentTitle;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.delegate = self;
   
    self.joinCntLabel.layer.masksToBounds = YES;
    self.joinCntLabel.layer.cornerRadius = 15;
  
    [[GODataCenter2 sharedInstance] requestPostRetrieveID:self.pk completion:^(BOOL isSuccess, id responseData) {
        
        if(isSuccess)
        {
           // NSLog(@"isSuccess: %lu", isSuccess);
            //NSLog(@"title: %@", [responseData objectForKey:@"title"]);
            
            self.selectedModel = [TalentDetailModel modelWithData:responseData];
            NSLog(@"title: %@", self.selectedModel.title);
            NSLog(@"region: %@", self.selectedModel.region);
            [self layoutDataInView];
            
        }else
        {
 
        }
    }];
}

- (void)getSeletedPk:(NSNumber *)selectedPk {
    self.pk = selectedPk;
}

- (void)layoutDataInView {
    self.talentTitle.text = self.selectedModel.title;
    self.talentRegion.text =  self.selectedModel.region;
    self.coverImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.selectedModel.img_cover_url]];
    self.hoursPerClass.text = [NSString stringWithFormat:@"%lu" ,self.selectedModel.hoursPerClass];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView.contentOffset.x: %lf", scrollView.contentOffset.x);
    if(scrollView.contentOffset.x == 0) {
        self.pageControl.currentPage = 0;
    }
    else if(scrollView.contentOffset.x == self.imageScrollView.frame.size.width) {
        self.pageControl.currentPage = 1;
    }
    else if(scrollView.contentOffset.x == self.imageScrollView.frame.size.width*2) {
        self.pageControl.currentPage = 2;
    }
      
}

- (void)setDetailData:(TalentDetailModel *)data
{
    //self.viewData = data;
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
