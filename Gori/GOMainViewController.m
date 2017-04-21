//
//  MainViewController.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 27..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "GOMainViewController.h"
#import "GOMainTableViewCell.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"
#import "GOLocationViewController.h"
#import "GOCategoryViewController.h"
#import "NetworkModuleMain.h"
#import "DetailViewController.h"
#import "GOMypageViewController.h"
#import "GODistrictLocationViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GOMainViewController ()
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic) IBOutlet UIButton *locationButton;
@property (nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) UIImageView *headerImageView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchDataSetTutorName;
@property (nonatomic, strong) NSArray *searchDataTutorNameResult;
@property (nonatomic, strong) NSMutableArray *tutorNameMutableArray;
@property (nonatomic, strong) NSArray *searchDataSetTitleName;
@property (nonatomic, strong) NSArray *searchDataTitleNameResult;
@property (nonatomic, strong) NSMutableArray *titleNameMutableArray;
@property NSDictionary *selectedData;

@property (nonatomic, strong) NSMutableArray *pkMutableArray;

@property (nonatomic, strong) NSDictionary *mainDataDictionary;
@property (nonatomic, strong) NSMutableArray *tableViewTitleImgURLArray;
@property (nonatomic, strong) NSMutableArray *tableViewTutorImgURLArray;
@property (nonatomic, strong) NSMutableArray *tableViewTitleImgArray;
@property (nonatomic, strong) NSMutableArray *tableViewTutorImgArray;

@property (nonatomic) UITextField *searchTextField;

@end

@implementation GOMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /***************** Setting DataCenter *****************/

    [[GODataCenter sharedInstance] settingCategoryArray];
    [[GODataCenter sharedInstance] settingSchoolLocationArray];
    [[GODataCenter sharedInstance] settingDistrictLocationArray];
    [[GODataCenter sharedInstance] settingDistrictLocationImageArray];
    [[GODataCenter sharedInstance] settingSchoolLocationImageArray];
    [[GODataCenter sharedInstance] settingCategoryImageArray];
    
    
    /***************** Setting Tableview *****************/
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
  
    /**************** tableViewHeader Footer Setting ********************************/
    UIView *tableViewHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.mainTableView.tableHeaderView = tableViewHeaderView;
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
    self.headerImageView = headerImageView;
    self.headerImageView.image = [UIImage imageNamed:@"headerImage.jpg"];
    [self.mainTableView.tableHeaderView addSubview:self.headerImageView];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.headerImageView.frame.size.width * 3/4, self.headerImageView.frame.size.height * 3/4)];
    headerLabel.center = CGPointMake(self.headerImageView.frame.size.width / 2, self.headerImageView.frame.size.height / 2);
    headerLabel.numberOfLines = 0;
    headerLabel.text = @"취미,\n같이할래?";
    headerLabel.font = [UIFont boldSystemFontOfSize:50.0f];
    headerLabel.textColor = [UIColor whiteColor];
    [self.headerImageView addSubview:headerLabel];
    
    /*************** searchTextField Setting *******************************/
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(5, 160, self.view.frame.size.width - 50, 40)];
    self.searchTextField.placeholder = @"강의명을 검색해보세요";
    self.searchTextField.borderStyle = UITextBorderStyleNone;
    self.searchTextField.delegate = self;
    self.searchTextField.tag = 100;
    [self.mainTableView.tableHeaderView addSubview:self.searchTextField];
    
    UIButton *searchTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchTitleButton.frame = CGRectMake(self.view.frame.size.width - 40, 165, 35, 35);
    
    [searchTitleButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchTitleButton addTarget:self action:@selector(showTitleDetailResult:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainTableView.tableHeaderView addSubview:searchTitleButton];
    
    
    /**************** navigationBar Logo Setting ********************************/
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0,0,70,70)];
    self.navigationItem.titleView = logoView;
    UIImageView *logoImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    logoImageView2.image = [UIImage imageNamed:@"logo.png"];
    [logoImageView2 setContentMode:UIViewContentModeScaleAspectFit];
    
    [logoView addSubview:logoImageView2];
    [[GODataCenter2 sharedInstance]getMyLoginToken];
    NSLog(@"뷰디드로드 겟마이토큰 : %@", [[GODataCenter2 sharedInstance]getMyLoginToken]);
}


/**************** button Action ********************************/

- (IBAction)showLocationDetailView:(id)sender {
    UIStoryboard *GOCategory_Location_Storyboard = [UIStoryboard storyboardWithName:@"Category_Location_Storyboard" bundle:nil];
    GOLocationViewController *GOlocationViewController = [GOCategory_Location_Storyboard instantiateViewControllerWithIdentifier:@"GOLocationViewController"];
    [self presentViewController:GOlocationViewController animated:YES completion:nil];
    
}

- (IBAction)showCategoryDetailView:(id)sender {
    
    UIStoryboard * Category_Location_Storyboard = [UIStoryboard storyboardWithName:@"Category_Location_Storyboard" bundle:nil];
    GOCategoryViewController *GOCategoryViewController = [Category_Location_Storyboard instantiateViewControllerWithIdentifier:@"GOCategoryViewController"];
    [self presentViewController:GOCategoryViewController animated:YES completion:nil];
}

- (void)showTitleDetailResult:(UIButton*)sender{
    NSString *titleKey = [NSString stringWithFormat:@"?title=%@", self.searchTextField.text];
    [self.searchTextField resignFirstResponder];
    [GODataCenter sharedInstance].filterTitleYN = YES;
    [GODataCenter sharedInstance].filterSchoolLocationYN = NO;
    [GODataCenter sharedInstance].filterCategoryYN = NO;
    [GODataCenter sharedInstance].filterDistrictLocationYN = NO;
    [[GODataCenter sharedInstance] receiveTitleFilteredDataWithCompletionBlock:titleKey completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"receiveTitleFilteredDataWithCompletionBlock sucess");
                [self.mainTableView reloadData];
                [[GODataCenter2 sharedInstance] getMyLoginToken];
                NSLog(@"메인 뷰컨트롤러에서 토큰 여부 체크 : %@", [[GODataCenter2 sharedInstance] getMyLoginToken]);
                NSLog(@"ReceivingServerData and ReloadingData is Completed");
            });
        }else{
            NSLog(@"ReceivingServerData and ReloadingData is Failed");
        }
    }];
}


/**************** tableviewDelegate ********************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return ([GODataCenter sharedInstance].networkDataArray.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GOMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[GOMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath: %lu", indexPath.row);
    //self.selectedData = [[GODataCenter2 sharedInstance].postList objectAtIndex:indexPath.row];
    //NSLog(@"%@", self.selectedData);
    self.selectedData = [[GODataCenter sharedInstance].networkDataArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailSegue" sender:nil];

}

/**************** textFieldDelegate ********************************/

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if(textField.tag != 100) {
//        [self.searchTextField resignFirstResponder];
//    }
//    
//    
//    return YES;
//}

//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
//    
//    [self.searchTextField resignFirstResponder];
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        DetailViewController *nextVC = segue.destinationViewController;
        //nextVC.pk = [self.selectedData objectForKey:@"pk"];
        [nextVC setSeletedPk:[self.selectedData objectForKey:@"pk"]];
        NSLog(@"pk: %@", [self.selectedData objectForKey:@"pk"]);
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    
    [super viewDidAppear:animated];
    
    if ([GODataCenter sharedInstance].filterDistrictLocationYN == YES) {
        
        [[GODataCenter sharedInstance] receiveDistrictLocationFilteredDataWithCompletionBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                 NSLog(@"receiveDistrictLocationFilteredDataWithCompletionBlock sucess");
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [self.mainTableView reloadData];
                    [[GODataCenter2 sharedInstance] getMyLoginToken];
                    NSLog(@"ReceivingServerData and ReloadingData is Completed");
                    });
            }else{
                NSLog(@"ReceivingServerData and ReloadingData is Failed");
            }
        }];
    }else if ([GODataCenter sharedInstance].filterCategoryYN == YES){
        [[GODataCenter sharedInstance] receiveCategoryFilteredDataWithCompletionBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mainTableView reloadData];
                    [[GODataCenter2 sharedInstance] getMyLoginToken];
                    NSLog(@"ReceivingServerData and ReloadingData is Completed");
                });
            }else{
                NSLog(@"ReceivingServerData and ReloadingData is Failed");
            }
        }];
    }else if ([GODataCenter sharedInstance].filterSchoolLocationYN == YES){
        [[GODataCenter sharedInstance] receiveDistrictLocationFilteredDataWithCompletionBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mainTableView reloadData];
                    [[GODataCenter2 sharedInstance] getMyLoginToken];
                    NSLog(@"ReceivingServerData and ReloadingData is Completed");
                });
            }else{
                NSLog(@"ReceivingServerData and ReloadingData is Failed");
            }
        }];
    }else{
        [[GODataCenter sharedInstance]receiveServerDataWithCompletionBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.mainTableView reloadData];
                    [[GODataCenter2 sharedInstance] getMyLoginToken];
                    NSLog(@"메인 뷰컨트롤러에서 토큰 여부 체크 : %@", [[GODataCenter2 sharedInstance] getMyLoginToken]);
                    NSLog(@"ReceivingServerData and ReloadingData is Completed");
                });
            }else{
                NSLog(@"ReceivingServerData and ReloadingData is Failed");
            }
        }];
    }
    
    
}

-(IBAction)unwindSegue:(UIStoryboardSegue *) sender {
    
    NSLog(@"등록 완료");
}


@end
