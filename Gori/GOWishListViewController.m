//
//  WishListViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 11..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOWishListViewController.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"
#import "GOWishListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GOWishListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation GOWishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**************** tableviewDelegate ********************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ([GODataCenter sharedInstance].networkDataArray.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GOWishListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[GOWishListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    /**************** changing cell image with networkDataArray ********************************/
    NSDictionary *temp = [[GODataCenter sharedInstance].networkDataArray objectAtIndex:indexPath.row];
    NSURL *titleURL = [NSURL URLWithString:[temp objectForKey:@"cover_image"]];
    NSURL *profileURL = [NSURL URLWithString:[[temp objectForKey:@"tutor"] objectForKey:@"profile_image"]];
    //    cell.titleImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:titleURL];
    //    cell.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:profileURL];
    //SDWebImage로 교체
    [cell.titleImageView sd_setImageWithURL:titleURL];
    [cell.profileImageView sd_setImageWithURL:profileURL];
    
    cell.tuteeCountIconImageView.image = [UIImage imageNamed:@"tuteeCountIcon.png"];
    cell.tutorNameLabel.text = [[temp objectForKey:@"tutor"] objectForKey:@"name"];
    cell.titleLabel.text = [temp objectForKey:@"title"];
    cell.tuteeCountNumberLabel.text = [[NSString stringWithFormat:@"%@", [temp objectForKey:@"registration_count"]] stringByAppendingString:@"명 참여"];
    return cell;
    //데이터 구조가 다름 윗 부분들 수정해야 함
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[GODataCenter sharedInstance]receiveUserWishListDataWithCompletionBlock:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.mainTableView reloadData];
                [[GODataCenter2 sharedInstance] getMyLoginToken];
                NSLog(@"ReceivingServerData and ReloadingData is Completed");
            });
        }else{
            
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
