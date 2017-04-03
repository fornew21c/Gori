//
//  GOCollectionView.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 31..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "GOCollectionViewController.h"
#import "GOMainViewController.h"
#import "GOCollectionViewCell.h"

@interface GOCollectionViewController ()
<UICollectionViewDelegate, UICollectionViewDataSource>

/**************** collectionViewConcept is Suspended ********************************/

@property (weak, nonatomic) IBOutlet UICollectionView *locationCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollectionView;

@end

@implementation GOCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationCollectionView.delegate = self;
    self.locationCollectionView.dataSource = self;
    
    self.categoryCollectionView.delegate = self;
    self.categoryCollectionView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GOCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 8;
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
