//
//  DataCenter.h
//  Gori
//
//  Created by ji jun young on 2017. 3. 29..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(BOOL isSuccess, id respons);

@interface GODataCenter : NSObject

@property (nonatomic) NSString *token;
@property (nonatomic) BOOL filterDistrictLocationYN;
@property (nonatomic) BOOL filterSchoolLocationYN;
@property (nonatomic) BOOL filterCategoryYN;
@property (nonatomic) BOOL filterTitleYN;
@property (nonatomic) NSString *titleKey;
@property (nonatomic) NSString *regionKey;
@property (nonatomic) NSString *categoryKey;
@property (nonatomic) NSData *userPicture;
/**************** Array for Setting with NetworkModule****************/
@property (nonatomic) NSArray *networkDataArray;
@property (nonatomic) NSDictionary *networkUserDetailDictionary;
@property (nonatomic) NSArray *districtLocationFilteredArray;
@property (nonatomic) NSArray *userRegistrationArray;
@property (nonatomic) NSArray *userWishListArray;

/**************** temporary Array for tableviewCell Setting ********************************/
@property (nonatomic) NSArray *titleArray;
@property (nonatomic) NSArray *tutorNameArray;
@property (nonatomic) NSArray *categoryArray;
@property (nonatomic) NSArray *categoryDetailArray;
@property (nonatomic) NSArray *schoolLocationArray;
@property (nonatomic) NSArray *districtLoactionArray;

/**************** temporary Array for LocationViewController and CategoryViewController Setting ***********************/
@property (nonatomic) NSArray *districtLocationImageArray;
@property (nonatomic) NSArray *schoolLocationImageArray;
@property (nonatomic) NSArray *categoryImageArray;

/**************** Deprecated. currentRow is replaced by networkDataArray ***********************/
//@property (nonatomic) NSInteger currentRow;

+ (instancetype)sharedInstance;
//- (NSArray *)settingTitleArray;
//- (NSArray *)settingTutorNameArray;
- (NSArray *)settingCategoryArray;
//- (NSArray *)settingCategoryDetailArray;
- (NSArray *)settingSchoolLocationArray;
- (NSArray *)settingDistrictLocationArray;
- (NSArray *)settingDistrictLocationImageArray;
- (NSArray *)settingSchoolLocationImageArray;
- (NSArray *)settingCategoryImageArray;

- (void)receiveServerDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock;
- (void)receiveServerUserDetailDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock;
- (void)receiveDistrictLocationFilteredDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock;
- (void)receiveCategoryFilteredDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock;
- (void)receiveTitleFilteredDataWithCompletionBlock:(NSString *)titleKey completion:(CompletionBlock)completion;
- (void)updatingUserDetailText:(NSString *)name nickName:(NSString *)nickName cellPhone:(NSString *)cellPhone completion:(CompletionBlock)completion;
- (void)updatingUserDetailImage:(NSData *)data completion:(CompletionBlock)completion;
- (void)receiveUserEnrollmentDataWithCompletionBlock:(CompletionBlock)completion;
- (void)receiveUserWishListDataWithCompletionBlock:(CompletionBlock)completion;

+ (void)setUserTokenWithString:(NSString *)tokenString;
+ (NSString *)getUserToken;
+ (void)removeUserToken;

@end
