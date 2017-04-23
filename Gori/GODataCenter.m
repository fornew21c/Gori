//
//  DataCenter.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 29..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "GODataCenter.h"
#import "NetworkModuleMain.h"

@interface GODataCenter()

@property (nonatomic) NetworkModuleMain *networkManager;

@end


@implementation
GODataCenter

+(instancetype)sharedInstance{
    static GODataCenter *dataCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataCenter = [[self alloc]init];
    });
    return dataCenter;
}

- (instancetype)init{
    self = [super init];
        if (self) {
            self.networkManager = [[NetworkModuleMain alloc]init];
            self.networkDataArray = [[NSArray alloc] init];
            self.networkUserDetailDictionary = [[NSDictionary alloc]init];
            self.districtLocationFilteredArray = [[NSArray alloc]init];
            self.userRegistrationArray = [[NSArray alloc]init];
            self.userWishListArray = [[NSArray alloc]init];
            
        }
        return self;
    
}

/**************** updating UserQuestion with NetworkModule********************************/

- (void)updatingUserQuestionText:(NSString *)question talentPK:(NSInteger)pk completion:(CompletionBlock)completion{
    [self.networkManager updatingUserQuestionWithCompletionBlock:question talentPk:pk completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            completion(YES, respons);
        }else{
            completion(NO, respons);
        }
    }];
}

/**************** receiving UserWithList and Registation with NetworkModule********************************/

- (void)receiveUserWishListDataWithCompletionBlock:(CompletionBlock)completion{
    [NetworkModuleMain getUserWishListWithCompletionBlock:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            NSArray *userWishListArray = [respons objectForKey:@"results"];
            self.userWishListArray = userWishListArray;
            completion(YES, respons);
        }else{
            completion(NO, respons);
        }
    }];
    
    
}


- (void)receiveUserEnrollmentDataWithCompletionBlock:(CompletionBlock)completion{
    [NetworkModuleMain getUserEnrollmentWithCompletionBlock:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            NSArray *userRegistrationArray = [respons objectForKey:@"results"];
            self.userRegistrationArray = userRegistrationArray;
            completion(YES, respons);
        }else{
            completion(NO, respons);
        }
    }];
    
    
}

/**************** updating myPageUserTextData with NetworkModule********************************/

- (void)updatingUserDetailImage:(NSData *)data completion:(CompletionBlock)completion{
    [self.networkManager updatingUserPictureWithCompletionBlock:data completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            completion(YES, respons);
        }else{
            completion(NO, respons);
        }
    }];
    
}

- (void)updatingUserDetailText:(NSString *)name nickName:(NSString *)nickName cellPhone:(NSString *)cellPhone completion:(CompletionBlock)completion{
    [self.networkManager updatingUserDetailTextDataWithCompletionBlock:name nickName:nickName cellPhone:cellPhone completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            completion(YES, respons);
        }else{
            completion(NO, respons);
        }
    }];
    
}

/**************** setting for MainView with NetworkModule********************************/
- (void)receiveServerDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock{
    
    [NetworkModuleMain getTalentListWithCompletionBlock:^(BOOL isSuccess, NSDictionary *result){
        if (isSuccess) {
            NSArray *networkDataArray = [result objectForKey:@"results"];
            self.networkDataArray = networkDataArray;
            completionBlock(YES);
        }else{
            completionBlock(NO);
        }
    }];
}

- (void)receiveTitleFilteredDataWithCompletionBlock:(NSString *)titleKey completion:(CompletionBlock)completion{
    [self.networkManager getFilteredTitleWithCompletionBlock:titleKey completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            NSArray *networkDataArray = [respons objectForKey:@"results"];
            self.networkDataArray = networkDataArray;
            completion(YES, respons);
        }else{
            completion(NO, respons);
        }
        
    }];
    
}

- (void)receiveCategoryFilteredDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock{
    [NetworkModuleMain getFilteredCategoryWithCompletionBlock:self.categoryKey completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            NSArray *networkDataArray = [respons objectForKey:@"results"];
            self.networkDataArray = networkDataArray;
            completionBlock(YES);
        }else{
            completionBlock(NO);
        }
    }];
    
}

- (void)receiveDistrictLocationFilteredDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock{
    
    [NetworkModuleMain getFilteredLocationWithCompletionBlock:self.regionKey completion:^(BOOL isSuccess, id respons) {
        if (isSuccess) {
            NSArray *networkDataArray = [respons objectForKey:@"results"];
            self.networkDataArray = networkDataArray;
            completionBlock(YES);
        }else{
            completionBlock(NO);
        }
    }];
}

/**************** setting for mypageView with NetworkModule********************************/
- (void)receiveServerUserDetailDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock{
    [NetworkModuleMain getUserDetailWithCompletionBlock:^(BOOL isSuccess, NSDictionary *result) {
        if (isSuccess) {
            NSDictionary *networkUserDetailDictionary = result;
            self.networkUserDetailDictionary = networkUserDetailDictionary;
            completionBlock(YES);
        }else{
            completionBlock(NO);
        }
    }];
}
/**************** setting for Location and Class Category ********************************/

- (NSArray *)settingCategoryArray{
    NSArray *categoryArray = @[@"전체", @"헬스&뷰티", @"외국어", @"컴퓨터", @"미술&음악", @"스포츠", @"전공&취업", @"이색취미", @"기타"];
    self.categoryArray = categoryArray;
    return  self.categoryArray;
}

- (NSArray *)settingSchoolLocationArray{
    NSArray *schoolLocationArray = @[@"전체", @"고려대", @"서울대", @"연세대", @"홍익대", @"이화여대", @"부산대", @"중앙대", @"건국대", @"한양대"];
    self.schoolLocationArray = schoolLocationArray;
    return self.schoolLocationArray;
}

- (NSArray *)settingDistrictLocationArray{
    NSArray *districtLocationArray = @[@"전체", @"강남", @"신촌", @"사당", @"잠실", @"종로", @"혜화", @"용산", @"합정", @"목동", @"기타"];
    self.districtLoactionArray = districtLocationArray;
    return self.districtLoactionArray;
}

- (NSArray *)settingDistrictLocationImageArray{
    NSArray *districtLocationImageArray = @[@"District_All.jpg", @"District_Kangnam.jpg", @"District_Sinchon.jpg", @"District_Sadang.jpg", @"District_Jamsil.jpg", @"District_Jongro.png", @"District_Hyehwa.png", @"District_Yongsan.jpeg", @"District_Hapjung.png", @"District_Mokdong.jpg", @"District_Etc.jpg"];
    self.districtLocationImageArray = districtLocationImageArray;
    return self.districtLocationImageArray;
}

- (NSArray *)settingSchoolLocationImageArray{
    NSArray *schoolLocationImageArray = @[@"School_All.jpeg", @"School_Kou.png", @"School_Snu.png", @"School_You.png", @"School_Hou.png", @"School_Ewwu.png", @"School_Bsu.png", @"School_Jau.png", @"School_Ggu.png", @"School_hyu.jpg"];
    self.schoolLocationImageArray = schoolLocationImageArray;
    return self.schoolLocationImageArray;
}

- (NSArray *)settingCategoryImageArray{
    NSArray *categoryImageArray = @[@"Category_All", @"Category_Heath_Beauty", @"Category_Language", @"Category_Computer", @"Category_Arts", @"Category_Sports", @"Category_JobStudy", @"Category_UniqueHobby", @"Category_ETC"];
    self.categoryImageArray = categoryImageArray;
    return self.categoryImageArray;
}




@end
