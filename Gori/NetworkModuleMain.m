//
//  NetworkModuleMain.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 9..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "NetworkModuleMain.h"
#import "GODataCenter.h"
#import "GODataCenter2.h"
#import <AFNetworking/AFNetworking.h>

static NSString *const API_BASE_URL     = @"https://mozzi.co.kr/api";

static NSString *const API_TALENT_URL = @"/talent/list/";

static NSString *const API_USER_DETAIL_URL = @"/member/profile/user/";

static NSString *const API_LOCATION_FILTER_URL     = @"/talent/list/";

static NSString *const API_CATEGORY_FILTER_URL     = @"/talent/list/";

static NSString *const API_TITLE_FILTER_URL     = @"/talent/list/";

static NSString *const API_USER_DETAIL_UPDATE_URL = @"/member/update/user/";

static NSString *const API_USER_WISH_LIST_URL = @"/member/wish-list/";

static NSString *const API_USER_REGISTRATION_LIST_URL = @"/member/registrations/";

static NSString *const API_USER_QUESTION_CREATE_URL = @"/talent/add/question/";

static NSString *const TOKEN_KEY = @"Authorization";

@interface NetworkModuleMain ()

@end

@implementation NetworkModuleMain


/**************** updating UserQuestion to BackEnd API ***********************/
- (void)updatingUserQuestionWithCompletionBlock:(NSString *)question talentPk:(NSInteger)pk completion:(CompletionBlock)completion{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_USER_QUESTION_CREATE_URL]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    NSString *body = [self updatingUserQuestion:question talentPK:pk];
     [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    NSString *loginToken = [[GODataCenter2 sharedInstance] getMyLoginToken];
    
    [request setValue:[NSString stringWithFormat:@"token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(NO,responseObject);
            
        } else {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSUInteger statusCode = (NSUInteger) [httpResponse statusCode];
            NSLog(@"statusCode: %lu", statusCode);
            if(statusCode == 201) {
                completion(YES,responseObject);
            }
            else if(statusCode == 400) {
                completion(NO,responseObject);
                NSLog(@"-----------------------response : %@", response);
            }
            else if(statusCode == 500) {
                completion(NO,responseObject);
                NSLog(@"----------------500-------response : %@", response);
            }
        }
    }];
    [dataTask resume];
}


/**************** gettingUserWishListData from BackEnd API ***********************/
+ (void)getUserWishListWithCompletionBlock:(CompletionBlock)completion{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_USER_WISH_LIST_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSString *loginToken = [[GODataCenter2 sharedInstance] getMyLoginToken];
    [request setValue:[NSString stringWithFormat:@"Token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(NO,nil);
        } else {
            completion(YES,responseObject);
        }
    }];
    [dataTask resume];
}


/**************** gettingUserEnrollmentData from BackEnd API ***********************/
+ (void)getUserEnrollmentWithCompletionBlock:(CompletionBlock)completion{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_USER_REGISTRATION_LIST_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSString *loginToken = [[GODataCenter2 sharedInstance] getMyLoginToken];
    [request setValue:[NSString stringWithFormat:@"Token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(NO,nil);
        } else {
            completion(YES,responseObject);
        }
    }];
    [dataTask resume];
}



/**************** updating UserDetailPictureData to BackEnd API ***********************/

- (void)updatingUserPictureWithCompletionBlock:(NSData*)data completion:(CompletionBlock)completion{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PATCH" URLString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, API_USER_DETAIL_UPDATE_URL] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"profile_image" fileName:@"profile_image.jpeg" mimeType:@"image/jpeg"];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    
    NSString *loginToken = [[GODataCenter2 sharedInstance] getMyLoginToken];
    [request setValue:[NSString stringWithFormat:@"Token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      
                      dispatch_async(dispatch_get_main_queue(), ^{
                          
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error == nil) {
                          completion(YES, response);
                      } else {
                          completion(NO, response);
                      }
                  }];
    
    [uploadTask resume];
}

/**************** updating UserDetailTextData to BackEnd API ***********************/
- (void)updatingUserDetailTextDataWithCompletionBlock:(NSString *)name nickName:(NSString *)nickName cellPhone:(NSString *)cellPhone completion:(CompletionBlock)completion{
    //session 생성
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    //Request 객체 생성
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,API_USER_DETAIL_UPDATE_URL] ;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *requestData = [self updatingUserInputText:name nickName:nickName cellPhone:cellPhone];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //body data set
    request.HTTPMethod = @"PATCH";
    NSString *loginToken = [[GODataCenter2 sharedInstance] getMyLoginToken];
    [request setValue:[NSString stringWithFormat:@"Token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    NSData *data = [requestData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSUInteger statusCode = (NSUInteger) [httpResponse statusCode];

                if(statusCode == 200) {
                    completion(YES,responseData);
                }
                else if(statusCode == 400) {
                    completion(NO,responseData);
                }

            }else
            {
                NSDictionary *responsData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                completion(NO,responsData);
            }
                                                        }];
    [task resume];
    
}

/**************** gettingFilteredTitleData from BackEnd API ***********************/

- (void)getFilteredTitleWithCompletionBlock:(NSString *)titleKey completion:(CompletionBlock)completion{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@%@", API_BASE_URL, API_TITLE_FILTER_URL, titleKey];
    
    NSString *encodedString = [stringForURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *URL = [NSURL URLWithString:encodedString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            completion(YES, responseObject);
        }else{
            completion(NO, nil);
        }
    }];
    [dataTask resume];
    
}

- (NSString*)updatingUserQuestion:(NSString *)question talentPK:(NSInteger)pk{
    return [NSString stringWithFormat:@"{\"content\":\"%@\",\"talent_pk\":\"%ld\"}",question, pk];
}


- (NSString*)updatingUserInputText:(NSString *)name nickName:(NSString *)nickName cellPhone:(NSString *)cellPhone{
    return [NSString stringWithFormat:@"{\"name\":\"%@\",\"nickname\":\"%@\",\"cellphone\":\"%@\"}",name,nickName,cellPhone];
}





/**************** gettingFilteredCategoryData from BackEnd API ***********************/
+ (void)getFilteredCategoryWithCompletionBlock:(NSString *)categoryKey completion:(CompletionBlock)completion{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", API_BASE_URL, API_CATEGORY_FILTER_URL, categoryKey]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            completion(YES, responseObject);
        }else{
            completion(NO, responseObject);
        }
    }];
    [dataTask resume];
}

/**************** gettingFilteredLocationData from BackEnd API ***********************/
+ (void)getFilteredLocationWithCompletionBlock:(NSString *)regionKey completion:(CompletionBlock)completion
{NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_BASE_URL,API_LOCATION_FILTER_URL,regionKey]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(NO,nil);
        } else {
            completion(YES,responseObject);
        }
    }];
    [dataTask resume];
}


/**************** gettingMainTableViewData from BackEnd API ***********************/
+ (void)getTalentListWithCompletionBlock:(void (^)(BOOL isSuccess, NSDictionary *result))completionBlock{
    // Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    // Request
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, API_TALENT_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"GET";
    
    // Get Task 요청
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            completionBlock(YES, responseDic);
            
        } else {
            NSLog(@"network error code %ld", error.code);
            completionBlock(NO, nil);
        }
    }];
    
    [getDataTask resume];
}

/**************** gettingUserDetailData from BackEnd API ***********************/
+ (void)getUserDetailWithCompletionBlock:(void (^)(BOOL isSuccess, NSDictionary *result))completionBlock{
    // session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    // Request
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, API_USER_DETAIL_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [request addValue:[NSString stringWithFormat:@"token %@", [[GODataCenter2 sharedInstance] getMyLoginToken]] forHTTPHeaderField:TOKEN_KEY];
    
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            completionBlock(YES, responseDic);
        } else {
            completionBlock(NO, nil);
        }
    }];
    
    [getDataTask resume];
    
}





@end
