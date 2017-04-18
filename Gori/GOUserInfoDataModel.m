//
//  GOUserInfoDataModel.m
//  Gori
//
//  Created by ji jun young on 2017. 4. 18..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOUserInfoDataModel.h"

@implementation GOUserInfoDataModel

//
//@property (nonatomic) NSInteger pk;
//@property (nonatomic) NSString *userId;
//@property (nonatomic) NSString *userName;
//@property (nonatomic) NSString *userNickName;
//@property (nonatomic) NSInteger *cellPhone;
//@property (nonatomic) NSMutableArray *region;
//@property (nonatomic) NSString *userType;
//@property (nonatomic) BOOL *tutorYN;
//@property (nonatomic) BOOL *staffYN;
//@property (nonatomic) BOOL *activeYN;
//@property (nonatomic) NSURL *profileImgURL;
//@property (nonatomic) NSInteger *receivedRegistrationsCount;
//@property (nonatomic) NSInteger *sentRegistrationsCount;
//@property (nonatomic) NSInteger *wishListCount;


+ (instancetype)modelWithData:(NSDictionary *)data{
    
    GOUserInfoDataModel *model = [[GOUserInfoDataModel alloc] init];
    
    if (data != nil) {
        model.pk = [[data objectForKey:@"pk"] integerValue];
        model.userId = [data objectForKey:@"user_id"];
        model.userName = [data objectForKey:@"name"];
        model.userNickName = [data objectForKey:@"nickname"];
        model.cellPhone = [data objectForKey:@"cellphone"];
        model.userType = [data objectForKey:@"user_type"];
        model.profileImgURL = [data objectForKey:@"profile_image"];
        model.receivedRegistrationsCount = [data objectForKey:@"received_registrations"];
        model.sentRegistrationsCount = [data objectForKey:@"sent_registrations"];
        model.wishListCount = [data objectForKey:@"wish_list"];
    }
    
        if (![[data objectForKey:@"pk"] isKindOfClass:[NSNull class]]) {
            model.pk = [[data objectForKey:@"pk"] integerValue];
        }else
        {
            model.pk = 0;
        }
        
        
        if (![[data objectForKey:@"profile_image"] isKindOfClass:[NSNull class]]) {
            model.profileImgURL = [NSURL URLWithString:[data objectForKey:@"profile_image"]] ;
        }else
        {
            model.profileImgURL = [NSURL URLWithString:@""];
        }
        
        if (![[data objectForKey:@"user_id"] isKindOfClass:[NSNull class]]) {
            model.userId = [data objectForKey:@"user_id"];
            
        }else
        {
            model.userId = @"";
        }
        
        if (![[data objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
            model.userName = [data objectForKey:@"name"];
            
        }else
        {
            model.userName = @"";
        }
        
        if (![[data objectForKey:@"nickname"] isKindOfClass:[NSNull class]]) {
            model.userNickName = [data objectForKey:@"nickname"];
            
        }else
        {
            model.userNickName = @"";
        }
        
        if (![[data objectForKey:@"cellphone"] isKindOfClass:[NSNull class]]) {
            model.cellPhone = [data objectForKey:@"cellphone"];
            
        }else
        {
            model.cellPhone = @"";
        }
        
        if (![[data objectForKey:@"user_type"] isKindOfClass:[NSNull class]]) {
            model.userType = [data objectForKey:@"user_type"];
            
        }else
        {
            model.userType = @"";
        }
        
        
        if (![[data objectForKey:@"received_registrations"] isKindOfClass:[NSNull class]]) {
            model.receivedRegistrationsCount = [data objectForKey:@"received_registrations"];
            
        }else
        {
            model.receivedRegistrationsCount = @0;
        }
        
        if (![[data objectForKey:@"sent_registrations"] isKindOfClass:[NSNull class]]) {
            model.sentRegistrationsCount = [data objectForKey:@"sent_registrations"];
        }else
        {
            model.sentRegistrationsCount = @0;
        }
        
        if (![[data objectForKey:@"wish_list"] isKindOfClass:[NSNull class]]) {
            model.wishListCount = [data objectForKey:@"wish_list"];
            
        }else
        {
            model.wishListCount = @0;
        }
        
    return model;

    
}

@end
