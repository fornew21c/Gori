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

- (void)updatingUserDetailTextDataWithCompletionBlock:(NSString *)name nickName:(NSString *)nickName cellPhone:(NSString *)cellPhone completion:(CompletionBlock)completion;


@end
