//
//  NetworkModuleMain.h
//  Gori
//
//  Created by ji jun young on 2017. 4. 9..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompletionBlock)(BOOL isSuccess, id respons);

@interface NetworkModuleMain : NSObject

+ (void)getTalentListWithCompletionBlock:(void (^)(BOOL isSuccess, NSDictionary *result))completionBlock;

+ (void)getUserDetailWithCompletionBlock:(void (^)(BOOL isSuccess, NSDictionary *result))completionBlock;

+ (void)getFilteredLocationWithCompletionBlock:(NSString *)regionKey completion:(CompletionBlock)completion;

+ (void)getFilteredCategoryWithCompletionBlock:(NSString *)categoryKey completion:(CompletionBlock)completion;

- (void)getFilteredTitleWithCompletionBlock:(NSString *)titleKey completion:(CompletionBlock)completion;

+ (void)getUserEnrollmentWithCompletionBlock:(CompletionBlock)completion;

+ (void)getUserWishListWithCompletionBlock:(CompletionBlock)completion;

- (void)updatingUserDetailTextDataWithCompletionBlock:(NSString *)name nickName:(NSString *)nickName cellPhone:(NSString *)cellPhone completion:(CompletionBlock)completion;
- (void)updatingUserPictureWithCompletionBlock:(NSData*)data completion:(CompletionBlock)completion;

@end
