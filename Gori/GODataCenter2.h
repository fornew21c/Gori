//
//  GODataCenter2.h
//  Gori
//
//  Created by Woncheol on 2017. 4. 7..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkModule.h"
#import "GOTalentDetailModel.h"

@interface GODataCenter2 : NSObject

@property (nonatomic, readonly) NSMutableArray *postList;
@property  GOTalentDetailModel *selectedModel;

//수업등록시 사용할 데이터
@property NSUInteger seletedRegionIndex;
@property NSUInteger seletedDayIndex;
@property BOOL locationSelectedBefore;
@property NSUInteger locationPK;
@property NSUInteger studentLevel;
@property NSString *messageToTutor;
@property NSUInteger experienceMonth;


+ (instancetype)sharedInstance;

- (NSString *)token;
- (BOOL)isAutoLogin;
- (BOOL)isAvaliblePageRequest;

//Login
- (void)loginWithEmail:(NSString *)userID pw:(NSString *)pw completion:(CompletionBlock)completion;
- (void)signupWithID:(NSString *)userID email:(NSString *)email pw:(NSString *)pw repw:(NSString *)repw completion:(CompletionBlock)completion;
- (void)logoutCompletion:(CompletionBlock)completion;
//post
- (void)postListWithPage:(NSInteger)page completion:(CompletionBlock)completion;
- (void)requestPostRetrieveID:(NSNumber*)pk completion:(CompletionBlock)completion;

- (void) setMyLoginToken:(NSString *)newToken;
- (NSString*) getMyLoginToken;

//수업신청
- (void)registerCreateWithLocationPK:(NSUInteger)locationPK
                        studentLevel:(NSUInteger)studentLevel
               studentExperienceMonth:(NSUInteger)studentExperienceMonth
                       messageToTutor:(NSString*)messageToTutor
                           completion:(CompletionBlock)completion;

//facebook login
- (void)loginWithFacebookid:(NSString*)facebookToken completion:(CompletionBlock)completion;
//좋아요
- (void)wishToggle:(NSNumber*)pk completion:(CompletionBlock)completion;
@end
