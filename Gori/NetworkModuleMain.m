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
//백엔드에서 말하기를 디테일뷰에서 "수업신청"을 하면 Registration에 쌓인다고 한다...즉 Enrollment 데이터를 따로 볼 수 는 없다고 한다 registration에서 수업, 유저 맞춰서 저장하면 수업 등록 가능합니다

static NSString *const TOKEN_KEY = @"Authorization";

@interface NetworkModuleMain ()

@end

@implementation NetworkModuleMain

/**************** gettingUserWishListData from BackEnd API ***********************/
+ (void)getUserWishListWithCompletionBlock:(CompletionBlock)completion{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_USER_WISH_LIST_URL]];
    NSLog(@"네트워크모듈의 유저 위시리스트 URL : %@", URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSString *loginToken = [[GODataCenter2 sharedInstance] getMyLoginToken];
    NSLog(@"네트워크모듈 메인의 토큰 : %@",loginToken);
    [request setValue:[NSString stringWithFormat:@"Token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@" 네트워크모듈메인의 유저위시리스트 Error: %@", error);
            completion(NO,nil);
        } else {
            // NSLog(@"%@ %@", response, responseObject);
            completion(YES,responseObject);
            NSLog(@"네트워크모듈메인의 유저위시리스트 리스폰스와 리스폰스 오브젝트 : %@", responseObject);
        }
    }];
    [dataTask resume];
}


/**************** gettingUserEnrollmentData from BackEnd API ***********************/
+ (void)getUserEnrollmentWithCompletionBlock:(CompletionBlock)completion{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_BASE_URL,API_USER_REGISTRATION_LIST_URL]];
    NSLog(@"네트워크모듈의 유저 레지스트레이션 URL : %@", URL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSString *loginToken = [[GODataCenter2 sharedInstance] getMyLoginToken];
    NSLog(@"네트워크모듈 메인의 토큰 : %@",loginToken);
    [request setValue:[NSString stringWithFormat:@"Token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
                        NSLog(@" 네트워크모듈메인의 유저레지스트레이션 Error: %@", error);
            completion(NO,nil);
        } else {
            // NSLog(@"%@ %@", response, responseObject);
            completion(YES,responseObject);
                        NSLog(@"네트워크모듈메인의 유저레지스트레이션 리스폰스와 리스폰스 오브젝트 : %@", responseObject);
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
    NSLog(@"네트워크모듈 메인의 토큰 : %@",loginToken);
    [request setValue:[NSString stringWithFormat:@"Token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
//                          [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error == nil) {
                          NSLog(@"%@ %@", response, responseObject);
                      } else {
                          NSLog(@"Error: %@", error);
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
    NSLog(@"네트워크모듈의 리퀘스트 데이터 : %@", requestData);
    //body data set
    request.HTTPMethod = @"PATCH";
    NSString *loginToken = [[GODataCenter2 sharedInstance] getMyLoginToken];
    NSLog(@"네트워크모듈 메인의 토큰 : %@",loginToken);
    // 헤더 세팅
    [request setValue:[NSString stringWithFormat:@"Token %@", loginToken] forHTTPHeaderField:TOKEN_KEY];
    NSData *data = [requestData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
//    NSLog(@"에이치티티피 데이타 : %@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"네트워크모듈메인의 데이터 : %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                NSUInteger statusCode = (NSUInteger) [httpResponse statusCode];
                // 받은 header들을 dictionary형태로 받음
                NSDictionary *responseHeaderFields = [(NSHTTPURLResponse *)response allHeaderFields];
                NSLog(@"스테이터스 코드 체크 : %lu", statusCode);
                NSLog(@"네트워크모듈 메인의 리스폰스 헤더 필드 네임 데이터:%@",[responseHeaderFields objectForKey:@"name"]);

                if(statusCode == 200) {
                    NSLog(@"마이페이지 텍스트 업데이트 성공");
//                    NSLog(@"key: %@", [responseData objectForKey:@"key"]);;
//                    [[GODataCenter2 sharedInstance] setMyLoginToken:[responseData objectForKey:@"key"]];
                    completion(YES,responseData);

                }
                else if(statusCode == 400) {
                    NSLog(@"non_field_errors: %@", [responseData objectForKey:@"non_field_errors"]);
                    completion(NO,responseData);


                }

            }else
            {
                NSDictionary *responsData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"%@",responsData);
                completion(NO,responsData);
            }
                                                        }];
    [task resume];
    
}

/**************** gettingFilteredTitleData from BackEnd API ***********************/

- (void)getFilteredTitleWithCompletionBlock:(NSString *)titleKey completion:(CompletionBlock)completion{
    //session 생성
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
//    
//    NSString *encodedStr = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    
//    NSURL *url = [NSURL URLWithString:encodedStr];
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    NSString *stringForURL = [NSString stringWithFormat:@"%@%@%@", API_BASE_URL, API_TITLE_FILTER_URL, titleKey];
    
    NSString *encodedString = [stringForURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *URL = [NSURL URLWithString:encodedString];
    NSLog(@"네트워크모듈 메인의 이름 필터링 데이터 : %@", [NSString stringWithFormat:@"%@",URL]);
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            completion(YES, responseObject);
            NSLog(@"네트워크모듈 리스폰스 데이터 : %@", responseObject);
        }else{
            NSLog(@"Error : %@", error);
            completion(NO, nil);
        }
    }];
    [dataTask resume];
    
}



- (NSString*)updatingUserInputText:(NSString *)name nickName:(NSString *)nickName cellPhone:(NSString *)cellPhone{
    return [NSString stringWithFormat:@"{\"name\":\"%@\",\"nickname\":\"%@\",\"cellphone\":\"%@\"}",name,nickName,cellPhone];
    
//    return [NSString stringWithFormat:@"name=%@&nickname=%@&cellphone=%@",name,nickName, cellPhone];
}





/**************** gettingFilteredCategoryData from BackEnd API ***********************/
+ (void)getFilteredCategoryWithCompletionBlock:(NSString *)categoryKey completion:(CompletionBlock)completion{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", API_BASE_URL, API_CATEGORY_FILTER_URL, categoryKey]];
    NSLog(@"네트워크모듈 메인의 지역 필터링 데이터 : %@", [NSString stringWithFormat:@"%@%@%@", API_BASE_URL, API_CATEGORY_FILTER_URL, categoryKey]);
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            completion(YES, responseObject);
        }else{
            NSLog(@"Error : %@", error);
            completion(NO, nil);
        }
    }];
    [dataTask resume];
}

/**************** gettingFilteredLocationData from BackEnd API ***********************/
+ (void)getFilteredLocationWithCompletionBlock:(NSString *)regionKey completion:(CompletionBlock)completion
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_BASE_URL,API_LOCATION_FILTER_URL,regionKey]];
    NSLog(@"네트워크모듈메인의 URL : %@", URL);
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
//            NSLog(@"Error: %@", error);
            completion(NO,nil);
        } else {
            // NSLog(@"%@ %@", response, responseObject);
            completion(YES,responseObject);
//            NSLog(@"네트워크모듈메인의 리스폰스와 리스폰스 오브젝트 : %@", responseObject);
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
    
    // Get Task 요청
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            completionBlock(YES, responseDic);
//            NSLog(@"네트워크모듈 메인의 딕셔너리 데이터 : %@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
        } else {
            NSLog(@"network error code %ld", error.code);
            completionBlock(NO, nil);
        }
    }];
    
    [getDataTask resume];
    
}





@end
