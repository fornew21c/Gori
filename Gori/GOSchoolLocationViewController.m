//
//  SchoolLocationViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 3..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOSchoolLocationViewController.h"
#import "GOSchoolLocationTableViewCell.h"
#import "GODataCenter.h"
#import "GOMainViewController.h"

@interface GOSchoolLocationViewController ()

@property (weak, nonatomic) IBOutlet UITableView *locationTableView;

@end

@implementation GOSchoolLocationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**************** tableviewDelegate ********************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [GODataCenter sharedInstance].schoolLocationArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GOSchoolLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GOSchoolLocationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.titleLabel.text = [[GODataCenter sharedInstance].schoolLocationArray objectAtIndex:indexPath.row];
    cell.titleImageView.image = [UIImage imageNamed:[[GODataCenter sharedInstance].schoolLocationImageArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [GODataCenter sharedInstance].filterSchoolLocationYN = YES;
    
    switch (indexPath.row) {
        case 0:
            [GODataCenter sharedInstance].regionKey = @"";
            break;
        case 1:
            [GODataCenter sharedInstance].regionKey = @"?region=kou";
            break;
        case 2:
            [GODataCenter sharedInstance].regionKey = @"?region=snu";
            break;
        case 3:
            [GODataCenter sharedInstance].regionKey = @"?region=you";
            break;
        case 4:
            [GODataCenter sharedInstance].regionKey = @"?region=hou";
            break;
        case 5:
            [GODataCenter sharedInstance].regionKey = @"?region=ewwu";
            break;
        case 6:
            [GODataCenter sharedInstance].regionKey = @"?region=bsu";
            break;
        case 7:
            [GODataCenter sharedInstance].regionKey = @"?region=jau";
            break;
        case 8:
            [GODataCenter sharedInstance].regionKey = @"?region=ggu";
            break;
        case 9:
            [GODataCenter sharedInstance].regionKey = @"?region=hyu";
            break;
       
        default:
            break;
    }
    [GODataCenter sharedInstance].filterDistrictLocationYN = NO;
    [GODataCenter sharedInstance].filterCategoryYN = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
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
