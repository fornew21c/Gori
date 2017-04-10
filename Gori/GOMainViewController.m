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
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchDataSetTitle;
@property (nonatomic, strong) NSArray *searchDataResult;


@end

@implementation GOMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**************** navigationBar Logo Setting ********************************/
    
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [logoView setImage:logo];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = logoView;
    
    /**************** tableView Setting ********************************/
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
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
    
    /**************** searchController Setting ********************************/
    self.searchDataSetTitle = [GODataCenter sharedInstance].networkDataArray;
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController = searchController;
    self.searchController.searchResultsUpdater = self;

    /**************** tableViewHeader Setting ********************************/
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

    /**************** button Action Setting ********************************/
    [self.locationButton addTarget:self action:@selector(showLocationDetailView:) forControlEvents:UIControlEventTouchUpInside];
    [self.categoryButton addTarget:self action:@selector(showCategoryDetailView:) forControlEvents:UIControlEventTouchUpInside];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    NSURL *titleURL = [NSURL URLWithString:[temp objectForKey:@"cover_image"]];
        cell.titleImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:titleURL]];
    NSURL *profileURL = [NSURL URLWithString:[[temp objectForKey:@"tutor"] objectForKey:@"profile_image"]];
        cell.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:profileURL]];
    
    if (self.searchController.isActive && (self.searchController.searchBar.text.length > 0)) {
        
        cell.titleLabel.text = self.searchDataResult[indexPath.row];
        
    }else{

        cell.titleLabel.text = [temp objectForKey:@"title"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}

/**************** searchController Protocol ********************************/

- (void)checkingText:(NSString *)string{
//    self.searchDataResult = [self.searchDataSetTitle mutableCopy];
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
