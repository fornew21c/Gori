//
//  GODataCenter2.h
//  Gori
//
//  Created by Woncheol on 2017. 4. 7..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkModule.h"
#import "PostModel.h"

@interface GODataCenter2 : NSObject

@property (nonatomic, readonly) NSMutableArray *postList;

+ (instancetype)sharedInstance;

- (NSString *)token;
- (BOOL)isAutoLogin;
- (BOOL)isAvaliblePageRequest;

//Login
- (void)loginWithID:(NSString *)userID pw:(NSString *)pw completion:(CompletionBlock)completion;
- (void)signupWithID:(NSString *)userID email:(NSString *)email pw:(NSString *)pw repw:(NSString *)repw completion:(CompletionBlock)completion;
- (void)logoutCompletion:(CompletionBlock)completion;
//post
- (void)creatPostWithTitle:(NSString *)title content:(NSString *)content image:(NSData *)imageData completion:(CompletionBlock)completion;
- (void)postListWithPage:(NSInteger)page completion:(CompletionBlock)completion;
- (void)requestPostRetrieveID:(NSNumber *)postID completion:(CompletionBlock)completion;

@end
