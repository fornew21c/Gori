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
    [GODataCenter sharedInstance].currentRow = indexPath.row;
    GOCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GOCategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell settingText];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heightForRow;
    GOCategoryTableViewCell *cell= [[GOCategoryTableViewCell alloc]init];
    heightForRow = cell.mainView.frame.size.height;
    return heightForRow;
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
