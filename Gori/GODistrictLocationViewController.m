//
//  LocationViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 31..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GODistrictLocationViewController.h"
#import "GODistrictLocationTableViewCell.h"
#import "GODataCenter.h"
#import "GOMainViewController.h"
#import "NetworkModuleMain.h"
typedef void(^CompletionBlock)(BOOL isSuccess, id respons);

@interface GODistrictLocationViewController ()
@property (weak, nonatomic) IBOutlet UITableView *locationTableView;

@end

@implementation GODistrictLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**************** tableviewDelegate ********************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [GODataCenter sharedInstance].districtLoactionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GODistrictLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GODistrictLocationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.titleLabel.text = [[GODataCenter sharedInstance].districtLoactionArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [GODataCenter sharedInstance].filterDistrictLocationYN = YES;
    
    switch (indexPath.row) {
        case 0:
            [GODataCenter sharedInstance].regionKey = @"";
            break;
        case 1:
            [GODataCenter sharedInstance].regionKey = @"?region=kn";
            break;
        case 2:
            [GODataCenter sharedInstance].regionKey = @"?region=sc";
            break;
        case 3:
            [GODataCenter sharedInstance].regionKey = @"?region=sd";
            break;
        case 4:
            [GODataCenter sharedInstance].regionKey = @"?region=js";
            break;
        case 5:
            [GODataCenter sharedInstance].regionKey = @"?region=jr";
            break;
        case 6:
            [GODataCenter sharedInstance].regionKey = @"?region=hh";
            break;
        case 7:
            [GODataCenter sharedInstance].regionKey = @"?region=hh";
            break;
        case 8:
            [GODataCenter sharedInstance].regionKey = @"?region=hj";
            break;
        case 9:
            [GODataCenter sharedInstance].regionKey = @"?region=md";
            break;
        case 10:
            [GODataCenter sharedInstance].regionKey = @"?region=etc";
            break;
        default:
            break;
    }
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
