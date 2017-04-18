//
//  GOUserInfoDataModel.h
//  Gori
//
//  Created by ji jun young on 2017. 4. 18..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOUserInfoDataModel : NSObject

@property (nonatomic) NSInteger pk;
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *userNickName;
@property (nonatomic) NSString *cellPhone;
@property (nonatomic) NSString *userType;
@property (nonatomic) NSURL *profileImgURL;
@property (nonatomic) NSNumber *receivedRegistrationsCount;
@property (nonatomic) NSNumber *sentRegistrationsCount;
@property (nonatomic) NSNumber *wishListCount;

+ (instancetype)modelWithData:(NSDictionary *)data;

@end
