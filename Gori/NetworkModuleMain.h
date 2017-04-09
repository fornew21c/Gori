//
//  NetworkModuleMain.h
//  Gori
//
//  Created by ji jun young on 2017. 4. 9..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkModuleMain : NSObject

+ (void)getTalentListWithCompletionBlock:(void (^)(BOOL isSuccess, NSDictionary *result))completionBlock;

@end
