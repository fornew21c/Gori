//
//  NetworkModule.h
//  NetworkProject
//
//  Created by youngmin joo on 2017. 3. 14..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(BOOL isSuccess, id respons);

static NSString * const BASE_URL = @"https://mozzi.co.kr/api";
/*
 HTTP METHOD : POST
 username	회원가입하는 사용자명	String
 password1	패스워드	String
 password2	패스워드 확인	String
 email	이메일	String
 
 Success Response:
   Code: 201
   Token key value
   "key": "4709a4a4174835ac846294f06f6486be9c02b20b"
 */
static NSString * const SIGNUP_URL = @"/member/signup/";    //POST
static NSString * const LOGIN_URL = @"/member/login/";      //GET
static NSString * const LOGOUT_URL = @"/member/logout/";    //POST
static NSString * const USERDETAIL_URL = @"/member/profile/";//GET
static NSString * const POST_URL = @"/post/";               //POST - MULTIPART
static NSString * const POST_LIST_URL = @"/post/";           //GET
static NSString * const POST_RETRIEVE_URL = @"/post/";           //GET /post/<post_pk>/


@interface NetworkModule : NSObject


- (void)signupRequestWithUserID:(NSString *)userID
                          email:(NSString *)email
                             pw:(NSString *)pw
                           repw:(NSString *)repw
                     completion:(CompletionBlock)completion;

- (void)loginRequestWithUserID:(NSString *)userID pw:(NSString *)pw completion:(CompletionBlock)completion;

- (void)logoutRequestCompletion:(CompletionBlock)completion;

- (void)postRequestWithTitle:(NSString *)title content:(NSString *)content image:(NSData *)imageData completion:(CompletionBlock)completion;
- (void)postListRequestWithPage:(NSNumber *)page completion:(CompletionBlock)completion;
- (void)postRetrieveRequestWithPostID:(NSNumber *)postID completion:(CompletionBlock)completion;

@end
