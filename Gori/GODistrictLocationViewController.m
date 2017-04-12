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

@interface GODistrictLocationViewController ()
<UITableViewDelegate, UITableViewDataSource>
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
    
    [GODataCenter sharedInstance].currentRow = indexPath.row;
    GODistrictLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GODistrictLocationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell settingText];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightForRow;
    GODistrictLocationTableViewCell *cell= [[GODistrictLocationTableViewCell alloc]init];
    heightForRow = cell.mainView.frame.size.height;
    return heightForRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
//            NSDictionary *temp = [[GODataCenter sharedInstance].networkDataArray objectAtIndex:indexPath.row];
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@", respons);
//                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 1:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=kn" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@", respons);
//                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 2:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=sc" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
//                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 3:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=sd" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
                    //                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 4:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=js" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
                    //                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 5:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=jr" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
                    //                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 6:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=hh" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
                    //                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 7:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=ys" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
                    //                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 8:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=hj" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
                    //                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 9:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=md" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
                    //                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        case 10:
            [NetworkModuleMain getFilteredLocationWithCompletionBlock:@"?region=etc" completion:^(BOOL isSuccess, id respons) {
                if (isSuccess) {
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드 : %@",respons);
                    //                    [GODataCenter sharedInstance].networkDataArray = (NSArray*)respons;
                }else{
                    NSLog(@"로케이션뷰컨트롤러의 리스폰드가 없음");
                    
                }
            }];
            break;
        default:
            break;
    }
    
    
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
