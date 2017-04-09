//
//  NetworkModuleMain.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 9..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "NetworkModuleMain.h"
#import "GODataCenter.h"

static NSString *const API_BASE_URL     = @"https://mozzi.co.kr/api";

static NSString *const API_TALENT_URL = @"/talent/list/";


@interface NetworkModuleMain ()

@end

@implementation NetworkModuleMain


/**************** gettingMainTableViewData from BackEnd API ***********************/
+ (void)getTalentListWithCompletionBlock:(void (^)(BOOL isSuccess, NSDictionary *result))completionBlock{
    // Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    // Request
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, API_TALENT_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPBody = [[NSString stringWithFormat:@"limit=%d", 10] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"GET";
    
    // Get Task 요청
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //        NSLog(@"initWithDataSection : %@", [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding]);
        //
        // NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]);
        
        if (error == nil) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"GetPostList");
            completionBlock(YES, responseDic);
            
            //            NSLog(@"%@", responseDic);
            
        } else {
            NSLog(@"network error code %ld", error.code);
            completionBlock(NO, nil);
        }
    }];
    
    [getDataTask resume];
}







@end
