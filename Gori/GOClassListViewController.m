//
//  ClassListViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 11..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOClassListViewController.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"
#import "GOClassListTableViewCell.h"
#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GOClassListViewController ()
<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) NSDictionary *selectedData;

@end

@implementation GOClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
}

/**************** tableviewDelegate ********************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return ([GODataCenter sharedInstance].userRegistrationArray.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GOClassListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[GOClassListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    /**************** changing cell image with networkDataArray ********************************/
    NSDictionary *temp = [[GODataCenter sharedInstance].userRegistrationArray objectAtIndex:indexPath.row];
    NSURL *titleURL = [NSURL URLWithString:[[temp objectForKey:@"talent"] objectForKey:@"cover_image"]];
    NSURL *profileURL = [NSURL URLWithString:[[temp objectForKey:@"tutor_info"]  objectForKey:@"profile_image"]];
    [cell.titleImageView sd_setImageWithURL:titleURL];
    [cell.profileImageView sd_setImageWithURL:profileURL];
    
    cell.tuteeCountIconImageView.image = [UIImage imageNamed:@"tuteeCountIcon.png"];
    cell.tutorNameLabel.text = [[temp objectForKey:@"tutor_info"] objectForKey:@"name"];
    cell.titleLabel.text = [[temp objectForKey:@"talent"] objectForKey:@"title"];
    cell.tuteeCountNumberLabel.text = [[NSString stringWithFormat:@"%@", [[temp objectForKey:@"talent"] objectForKey:@"registration_count"]] stringByAppendingString:@"명 참여"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 225;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedData = [[GODataCenter sharedInstance].userRegistrationArray objectAtIndex:indexPath.row];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *DetailViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    DetailViewController.pk = [[self.selectedData objectForKey:@"talent"] objectForKey:@"pk"];
    [self.navigationController pushViewController:DetailViewController animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[GODataCenter sharedInstance]receiveUserEnrollmentDataWithCompletionBlock:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.mainTableView reloadData];
                [[GODataCenter2 sharedInstance] getMyLoginToken];
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
