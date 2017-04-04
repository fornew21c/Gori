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


@interface GOMainViewController ()
<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) UITableView *mainTableView;

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
    
    NSLog(@"TEST");
    
    /**************** navigationBar Logo Setting ********************************/
    
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [logoView setImage:logo];
    //set Content Mode Aspect Fit
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = logoView;
    
    /**************** tableView Setting ********************************/
    
    UITableView *mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStylePlain];
    self.mainTableView = mainTableView;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    /**************** searchController Setting ********************************/
    self.searchDataSetTitle = [GODataCenter sharedInstance].titleArray;
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController = searchController;
    self.searchController.searchResultsUpdater = self;
    self.mainTableView.tableHeaderView = self.searchController.searchBar;
    
    
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
    
   return ([GODataCenter sharedInstance].titleArray.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [GODataCenter sharedInstance].currentRow = indexPath.row;
    
    GOMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[GOMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell settingText];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat heightForRow;
    GOMainTableViewCell *cell= [[GOMainTableViewCell alloc]init];
    heightForRow = cell.mainView.frame.size.height;
    return heightForRow;
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
