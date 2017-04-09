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
#import "GOLocationViewController.h"
#import "GOCategoryViewController.h"
#import "NetworkModuleMain.h"


@interface GOMainViewController ()
<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) UIImageView *headerImageView;

//     지역, 카테고리는 별도의 뷰 컨트롤러로 띄울 것이므로 주석 처리함
//@property (nonatomic) UIView *locationDetailView;
//@property (nonatomic) UIView *categoryDetailView;
//@property (nonatomic) BOOL viewIsPresented;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchDataSetTitle;
@property (nonatomic, strong) NSArray *searchDataResult;


@end

@implementation GOMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"GitCommitTest");
    
    /**************** navigationBar Logo Setting ********************************/
    
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [logoView setImage:logo];
    //set Content Mode Aspect Fit
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = logoView;
    
    /**************** tableView Setting ********************************/
    
//    UITableView *mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
//    self.mainTableView = mainTableView;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
//    [self.view addSubview:self.mainTableView];
    [[GODataCenter sharedInstance]receiveServerDataWithCompletionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainTableView reloadData];
                NSLog(@"ReceivingServerData and ReloadingData is Completed");
            });
        }else{
            NSLog(@"ReceivingServerData and ReloadingData is Failed");
        }
    }];
    
    /**************** Deprecated due to if/else issue ***********************/
    //    [[DataCenter sharedInstance] receivingServerDatawithCompletionBlock:^{
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self.mainTableView reloadData];
    //        });
    //
    //        NSLog(@"receivingServerDatawithCompletionBlock, reloadData");
    //    }];


    
    
    /**************** searchController Setting ********************************/
    self.searchDataSetTitle = [GODataCenter sharedInstance].titleArray;
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController = searchController;
    self.searchController.searchResultsUpdater = self;
//    self.mainTableView.tableHeaderView = self.searchController.searchBar;
//    self.mainTableView.tableHeaderView = self.headerImageView;
    
    /**************** tableViewHeader Setting ********************************/
//    self.searchController.view.frame = CGRectMake(0, 125, self.view.frame.size.width, 25);
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
    
    UIView *searchControllerView = [[UIView alloc]initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 40)];
    [self.mainTableView.tableHeaderView addSubview:searchControllerView];
    [searchControllerView addSubview:self.searchController.searchBar];
//    [self.mainTableView.tableHeaderView addSubview:self.headerImageView];
//    [self.headerImageView addSubview:self.searchController.searchBar];
//    
    
    
//     지역, 카테고리는 별도의 뷰 컨트롤러로 띄울 것이므로 주석 처리함
//    /**************** location,category detailView Setting ********************************/
//    
//    //프레임설정은 버튼 메소드에서 걸어주었음...프레임 값은 나중에 지워도 무방함
//    UIView *locationDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height * 2/3)];
//    self.locationDetailView = locationDetailView;
//    self.locationDetailView.backgroundColor = [UIColor whiteColor];
//    
//    //프레임설정은 버튼 메소드에서 걸어주었음...프레임 값은 나중에 지워도 무방함
//    UIView *categoryDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height * 2/3)];
//    self.categoryDetailView = categoryDetailView;
//    self.categoryDetailView.backgroundColor = [UIColor whiteColor];
//    
    /**************** button Action Setting ********************************/
    [self.locationButton addTarget:self action:@selector(showLocationDetailView:) forControlEvents:UIControlEventTouchUpInside];
    [self.categoryButton addTarget:self action:@selector(showCategoryDetailView:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


/**************** button Action ********************************/

- (IBAction)showLocationDetailView:(id)sender {
    UIStoryboard *GOCategory_Location_Storyboard = [UIStoryboard storyboardWithName:@"Category_Location_Storyboard" bundle:nil];
    GOLocationViewController *GOlocationViewController = [GOCategory_Location_Storyboard instantiateViewControllerWithIdentifier:@"GOLocationViewController"];
    [self presentViewController:GOlocationViewController animated:YES completion:nil];

    
//    디테일뷰는 다른 뷰컨트롤러 생성 후 띄울 것이므로 주석 처리함
//    if (self.viewIsPresented == NO) {
//
//        /**************** location,category detailView Setting ********************************/
//        self.locationDetailView.frame = CGRectMake(0, 100, self.view.frame.size.width, 0);
//        [self.view addSubview:self.locationDetailView];
//        [UIView animateWithDuration:0.3 animations:^{
//            self.locationDetailView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height * 2/3);
//            [self.mainTableView setAlpha:0.1f];
//        }];
//        self.viewIsPresented = YES;
//    } else {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.locationDetailView.frame = CGRectMake(0, 100, self.view.frame.size.width, 0);
//            self.categoryDetailView.frame = CGRectMake(0, 100, self.view.frame.size.width, 0);
//            [self.mainTableView setAlpha:1.0f];} completion:^(BOOL finished) {[self.locationDetailView removeFromSuperview]; [self.categoryDetailView removeFromSuperview];
//        }];
//        self.viewIsPresented = NO;
//    }
    
}

- (IBAction)showCategoryDetailView:(id)sender {
    
    UIStoryboard * Category_Location_Storyboard = [UIStoryboard storyboardWithName:@"Category_Location_Storyboard" bundle:nil];
    GOCategoryViewController *GOCategoryViewController = [Category_Location_Storyboard instantiateViewControllerWithIdentifier:@"GOCategoryViewController"];
    [self presentViewController:GOCategoryViewController animated:YES completion:nil];
    
//    디테일뷰는 다른 뷰컨트롤러 생성 후 띄울 것이므로 주석 처리함
//    if (self.viewIsPresented == NO) {
//        
//        /**************** location,category detailView Setting ********************************/
//        self.categoryDetailView.frame = CGRectMake(0, 100, self.view.frame.size.width, 0);
//        [self.view addSubview:self.categoryDetailView];
//        self.viewIsPresented = YES;
//        [UIView animateWithDuration:0.3 animations:^{
//            self.categoryDetailView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height * 2/3);
//            [self.mainTableView setAlpha:0.1];
//        }];
//        
//    }else{
//        [UIView animateWithDuration:0.3 animations:^{
//            self.categoryDetailView.frame = CGRectMake(0, 100, self.view.frame.size.width, 0);
//            self.locationDetailView.frame = CGRectMake(0, 100, self.view.frame.size.width, 0);
//            [self.mainTableView setAlpha:1.0];
//        } completion:^(BOOL finished) {
//            [self.categoryDetailView removeFromSuperview];
//            [self.locationDetailView removeFromSuperview];
//        }];
//        self.viewIsPresented = NO;
//    }
}

/**************** tableviewDelegate ********************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.isActive && (self.searchController.searchBar.text.length > 0)) {
        return self.searchDataResult.count;
    }
    
   return ([GODataCenter sharedInstance].networkDataArray.count);
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (self.searchController.isActive && (self.searchController.searchBar.text.length > 0)) {
//        return  self.resultData.count;
//    }
//    
//    return  self.allData.count;
//}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /**************** Deprecated. currentRow is replaced by networkDataArray ***************/
//    [GODataCenter sharedInstance].currentRow = indexPath.row;
    GOMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[GOMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    /**************** changing cell text with networkDataArray ********************************/
    NSDictionary *temp = [[GODataCenter sharedInstance].networkDataArray objectAtIndex:indexPath.row];
    
    //cell이 별도의 메소드를 사용해서 불러오는 것 보다는 하단의 방법으로 텍스트와 이미지를 바꾸는 것이 더 낫다고 함
    //왜냐하면 tableview의 dataSource가 self(ViewController) 이므로
    cell.tutorNameLabel.text = [[temp objectForKey:@"tutor"] objectForKey:@"name"];
    cell.titleLabel.text = [temp objectForKey:@"title"];
    cell.tuteeCountNumberLabel.text = [[NSString stringWithFormat:@"%@", [temp objectForKey:@"registration_count"]] stringByAppendingString:@"명 참여"];
    
    /**************** changing cell image with networkDataArray ********************************/
    NSString *titleImageViewURL = [NSString stringWithFormat:@"%@", [temp objectForKey:@"cover_image"]];
    NSURL *titleURL = [NSURL URLWithString:titleImageViewURL];
    cell.titleImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:titleURL]];
    
    NSString *profileImageViewURL = [NSString stringWithFormat:@"%@", [[temp objectForKey:@"tutor"] objectForKey:@"profile_image"]];
    NSURL *profileURL = [NSURL URLWithString:profileImageViewURL];
    cell.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:profileURL]];
    
    //해당 코드는 메인스레드에서 돌아가는 코드임...따라서 이미지를 여러개 불러올 경우엔 이미지가 다 불러질 때까지 기다리게 됨...따라서 ui도 안먹히게 됨...즉 비동기 처리를 해줘야 함
    
    //    NSLog(@"%ld", [DataCenter sharedInstance].currentRow);
    
    
    if (self.searchController.isActive && (self.searchController.searchBar.text.length > 0)) {
        
        cell.titleLabel.text = self.searchDataResult[indexPath.row];
        
        //서치컨트롤러 시행 후, 제목 정확히 입력시 검색됨...튜터 이름, 수강생 명수도 같이 바뀌도록 여러 메소드를 구현해야 함
    }else{
        /******** must be Deprecated due to setting tableView Data issue *******************/
//        [cell settingText:indexPath];
    }
    
    /**************** Deprecated due to setting tableView Data issue ***********************/
    //    [cell settingText:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
//    if (self.searchController.isActive && (self.searchController.searchBar.text.length > 0)) {
//        cell.textLabel.text = self.resultData[indexPath.row];
//    }else
//    {
//        cell.textLabel.text = self.allData[indexPath.row];
//    }
//    
//    
//    
//    
//    return cell;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat heightForRow;
//    GOMainTableViewCell *cell= [[GOMainTableViewCell alloc]init];
//    heightForRow = cell.mainView.frame.size.height;
//    return heightForRow;
    
    return 200;
}

/**************** searchController Protocol ********************************/

- (void)checkingText:(NSString *)string{
    self.searchDataResult = [self.searchDataSetTitle mutableCopy];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", string];
    self.searchDataResult = [self.searchDataSetTitle filteredArrayUsingPredicate:predicate];
    [self.mainTableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [self checkingText:searchController.searchBar.text];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath: %lu", indexPath.row);
    [self performSegueWithIdentifier:@"detailSegue" sender:nil];
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
