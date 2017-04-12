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

@interface NetworkModuleMain ()

@end

@implementation NetworkModuleMain

/**************** gettingFilteredLocationData from BackEnd API ***********************/
+ (void)getFilteredLocationWithCompletionBlock:(NSString*)regionKey completion:(CompletionBlock)completion
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",API_BASE_URL,API_LOCATION_FILTER_URL,regionKey]];
    NSLog(@"네트워크모듈메인의 URL : %@", URL);
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completion(NO,error);
        } else {
            // NSLog(@"%@ %@", response, responseObject);
            completion(YES,responseObject);
            NSLog(@"네트워크모듈메인의 리스폰스와 리스폰스 오브젝트 : %@", responseObject);
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

+ (void)getUserDetailWithCompletionBlock:(void (^)(BOOL isSuccess, NSDictionary *result))completionBlock{
    // session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    // Request
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, API_USER_DETAIL_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    [request addValue:[NSString stringWithFormat:@"token %@", [[GODataCenter2 sharedInstance] getMyLoginToken]] forHTTPHeaderField:@"Authorization"];
    
    // Get Task 요청
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            completionBlock(YES, responseDic);
            NSLog(@"네트워크모듈 메인의 딕셔너리 데이터 : %@", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
        } else {
            NSLog(@"network error code %ld", error.code);
            completionBlock(NO, nil);
        }
    }];
    
    [getDataTask resume];
    
}





@end
