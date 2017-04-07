//
//  NetworkModule.m
//  NetworkProject
//
//  Created by youngmin joo on 2017. 3. 14..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

#import "NetworkModule.h"
#import "GODataCenter2.h"


static NSString *const TOKEN_KEY = @"Authorization";
@implementation NetworkModule


- (void)loginRequestWithUserID:(NSString *)userID pw:(NSString *)pw completion:(CompletionBlock)completion
{
    //session 생성
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    //Request 객체 생성
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASE_URL,LOGIN_URL] ;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *requstData = [self loginBodyUserName:userID password:pw];
    
    //body data set
    request.HTTPMethod = @"POST";
    request.HTTPBody = [requstData dataUsingEncoding:NSUTF8StringEncoding];
    //post Tast 요청
    
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request
                                                         fromData:nil
                                                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    if (error == nil) {
                                                        NSDictionary *responsData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                        NSLog(@"%@",responsData);
                                                        completion(YES,responsData);
                                                                                                                
                                                    }else
                                                    {
                                                        NSDictionary *responsData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                        NSLog(@"%@",responsData);
                                                        completion(NO,responsData);
                                                    }
                                                }];
    [task resume];

}

- (void)signupRequestWithUserID:(NSString *)userID
                          email:(NSString *)email
                             pw:(NSString *)pw
                           repw:(NSString *)repw
                     completion:(CompletionBlock)completion
{
    
    //session 생성
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //Request 객체 생성
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,SIGNUP_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //data Data 생성
    NSString *requestData = [self signupBodyUserName:userID email:email password:pw reEnter:repw];
    
    //body data set
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [requestData dataUsingEncoding:NSUTF8StringEncoding];
    //post Tast 요청
   // [NSString alloc] initWi
    NSLog(@"request Data: %@", requestData);

    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request
                                                        fromData:nil
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                            
                                                            if (error == nil) {
                                                                NSDictionary *responsData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                                NSLog(@"responsData: %@",responsData);
                                                                
                                                                completion(YES, responsData);
                                                            }else
                                                            {
                                                                NSDictionary *responsData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                                completion(NO, responsData);
                                                            }
                                                        }];
    
    [task resume];
}


- (void)logoutRequestCompletion:(CompletionBlock)completion
{
    //session 생성
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    //Request 객체 생성
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,LOGOUT_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
    [request setValue:[self tokenValue] forHTTPHeaderField:TOKEN_KEY];
    
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request
                                                         fromData:nil
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                                    if (error != nil) {
                                                        completion(NO, nil);
                                                    }else
                                                    {
                                                        NSDictionary *responsData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                        NSLog(@"%@",responsData);
                                                        
                                                        completion(YES,responsData);
                                                    }
                                                }];
    
    [task resume];
}


- (void)postRequestWithTitle:(NSString *)title content:(NSString *)content image:(NSData *)imageData completion:(CompletionBlock)completion
{
    
    //session 생성
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //Request 객체 생성
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,POST_URL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:[self tokenValue] forHTTPHeaderField:TOKEN_KEY];
    
    /****************************Multipart Data**************************/
    NSString *boundary = @"------------0x0x0x0x0x0x0x0x";
    NSMutableData *body = [NSMutableData data];
    //start boundary
    ///////////타이틀 정보
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n%@", title] dataUsingEncoding:NSUTF8StringEncoding]];
    ///////////컨텐츠  정보
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"content\"\r\n\r\n%@", content] dataUsingEncoding:NSUTF8StringEncoding]];
    ///////////이미지 정보
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"img_cover\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];    
    //End boundary
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    /****************************Multipart Data End**************************/
    
    //body에 셋팅
    request.HTTPBody = body;
    NSString* multiPartContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:multiPartContentType forHTTPHeaderField: @"Content-Type"];
    
    //request
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request
                                                         fromData:nil
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    if (error == nil) {
                                                        NSDictionary *responsData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                        NSLog(@"%@",responsData);
                                                        completion(YES,responsData);
                                                    }else
                                                    {
                                                        completion(NO,error);
                                                    }
                                                }];
    
    [task resume];
    
}

- (void)postListRequestWithPage:(NSNumber *)page completion:(CompletionBlock)completion
{
    //session 생성
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    //Request 객체 생성
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page=%@",BASE_URL,POST_LIST_URL,page]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                if (error == nil) {
                                                    NSDictionary *responsData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                    NSLog(@"%@",responsData);
                                                    
                                                    completion(YES,responsData);
                                                }else
                                                {
                                                    completion(NO,error);
                                                }

                                            }];
    
    [task resume];
}

- (void)postRetrieveRequestWithPostID:(NSNumber *)postID completion:(CompletionBlock)completion
{
    //session 생성
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             [NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //Request 객체 생성
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/",BASE_URL,POST_RETRIEVE_URL,postID]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
//    [request setValue:[[DataCenter sharedInstance] token] forHTTPHeaderField:TOKEN_KEY];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                               
                                                if (error == nil) {
                                                    NSDictionary *responsData =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                                    NSLog(@"%@",responsData);
                                                    
                                                    completion(YES,responsData);
                                                }else
                                                {
                                                    completion(NO,error);
                                                }
                                                
                                            }];
    
    [task resume];
}

#pragma mark - PrivateMethod


- (NSString *)tokenValue
{
    
    return [NSString stringWithFormat:@"Token %@",[[GODataCenter2 sharedInstance] token]];
}


- (NSString *)signupBodyUserName:(NSString *)userName email:(NSString *)email password:(NSString *)pw reEnter:(NSString *)repw
{
    return [NSString stringWithFormat:@"name=%@&username=%@&password1=%@&password2=%@",userName,email,pw,repw];
}


- (NSString *)loginBodyUserName:(NSString *)userName password:(NSString *)pw
{
    return [NSString stringWithFormat:@"username=%@&password=%@", userName, pw];
}



@end
