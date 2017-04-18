//
//  curriculumViewController.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 17..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "curriculumViewController.h"
#import "GODataCenter2.h"
@interface curriculumViewController ()
<UITableViewDelegate,UITableViewDataSource>
@end

@implementation curriculumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [GODataCenter2 sharedInstance].selectedModel.curriculums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [[[GODataCenter2 sharedInstance].selectedModel.curriculums objectAtIndex:indexPath.row] objectForKey:@"information"];
    
    return cell;
}
@end
