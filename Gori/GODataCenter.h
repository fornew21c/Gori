//
//  DataCenter.h
//  Gori
//
//  Created by ji jun young on 2017. 3. 29..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GODataCenter : NSObject

@property (nonatomic) NSString *token;
@property (nonatomic) BOOL filterDistrictLocationYN;
@property (nonatomic) BOOL filterCategoryYN;
@property (nonatomic) NSString *regionKey;
@property (nonatomic) NSString *categoryKey;
/**************** temporary Array for Setting with NetworkModule****************/
@property (nonatomic) NSArray *networkDataArray;
@property (nonatomic) NSDictionary *networkUserDetailDictionary;
@property (nonatomic) NSArray *districtLocationFilteredArray;

/**************** temporary Array for tableviewCell Setting ********************************/
@property (nonatomic) NSArray *titleArray;
@property (nonatomic) NSArray *tutorNameArray;
@property (nonatomic) NSArray *categoryArray;
@property (nonatomic) NSArray *categoryDetailArray;
@property (nonatomic) NSArray *schoolLocationArray;
@property (nonatomic) NSArray *districtLoactionArray;

/**************** Deprecated. currentRow is replaced by networkDataArray ***********************/
@property (nonatomic) NSInteger currentRow;

+ (instancetype)sharedInstance;
- (NSArray *)settingTitleArray;
- (NSArray *)settingTutorNameArray;
- (NSArray *)settingCategoryArray;
- (NSArray *)settingCategoryDetailArray;
- (NSArray *)settingSchoolLocationArray;
- (NSArray *)settingDistrictLocationArray;

- (void)receiveServerDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock;
- (void)receiveServerUserDetailDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock;
- (void)receiveDistrictLocationFilteredDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock;
- (void)receiveCategoryFilteredDataWithCompletionBlock:(void (^)(BOOL isSuccess))completionBlock;

+ (void)setUserTokenWithString:(NSString *)tokenString;
+ (NSString *)getUserToken;
+ (void)removeUserToken;

@end
