//
//  DetailViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 4..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "DetailViewController.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"

@interface DetailViewController ()
<UIScrollViewDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.delegate = self;


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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
