//
//  CategoryViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 31..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOCategoryViewController.h"
#import "GODataCenter.h"
#import "GOCategoryTableViewCell.h"

@interface GOCategoryViewController ()
<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *backToMainViewButton;


@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation GOCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**************** tableviewDelegate ********************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [GODataCenter sharedInstance].categoryArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GOCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GOCategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.titleLabel.text = [[GODataCenter sharedInstance].categoryArray objectAtIndex:indexPath.row];
    cell.titleImageView.image = [UIImage imageNamed:[[GODataCenter sharedInstance].categoryImageArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [GODataCenter sharedInstance].filterCategoryYN = YES;
    [GODataCenter sharedInstance].filterDistrictLocationYN = NO;

    switch (indexPath.row) {
        case 0:
            [GODataCenter sharedInstance].categoryKey = @"";
            break;
        case 1:
            [GODataCenter sharedInstance].categoryKey = @"?category=hnb";
            break;
        case 2:
            [GODataCenter sharedInstance].categoryKey = @"?category=lan";
            break;
        case 3:
            [GODataCenter sharedInstance].categoryKey = @"?category=com";
            break;
        case 4:
            [GODataCenter sharedInstance].categoryKey = @"?category=art";
            break;
        case 5:
            [GODataCenter sharedInstance].categoryKey = @"?category=spo";
            break;
        case 6:
            [GODataCenter sharedInstance].categoryKey = @"?category=job";
            break;
        case 7:
            [GODataCenter sharedInstance].categoryKey = @"?category=hob";
            break;
        case 8:
            [GODataCenter sharedInstance].categoryKey = @"?category=etc";
            break;
        default:
            break;
    }
    
    
    
    NSLog(@"didSelectRowAtIndexPath");
    //디스미스가 느려지는 이유를 찾지 못함...메인큐로 넣으면 빨라지는 것으로 보아, 모르는 곳에서 스레드가 돌 고 있으나 찾기가 어려움...
    //리팩토링을 해야 한다고 함
    //또한 메인 뷰컨트롤러의 테이블뷰 델리게이트에서 if,else를 쓰는 것은 의미가 없음...
    //셀 설력센 스타일을 none으로 설정해 둔 코드를 주석처리하니 디스미스가 다소 빨라짐...
    [self dismissViewControllerAnimated:YES completion:nil];
//    dispatch_async(dispatch_get_main_queue(), ^{
//       [self dismissViewControllerAnimated:YES completion:nil];
//    });
}

/**************** button Action ********************************/

- (IBAction)backToMainView:(UIButton *)sender {
    
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
