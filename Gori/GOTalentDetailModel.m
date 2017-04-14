//
//  PostModel.m
//  NetworkProject
//
//  Created by youngmin joo on 2017. 3. 16..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

#import "GOTalentDetailModel.h"

@implementation GOTalentDetailModel

+ (instancetype)modelWithData:(NSDictionary *)data
{
    GOTalentDetailModel *model = [[GOTalentDetailModel alloc] init];
    
    if (data != nil) {
        model.postID = [[data objectForKey:@"pk"] integerValue];
        model.title = [data objectForKey:@"title"];
        model.locations = [data objectForKey:@"locations"];
        //model.region = [[[data objectForKey:@"locations"] objectAtIndex:0]  objectForKey:@"region"];
        model.region = @"";
        
        if (model.locations.count != 0) {
            for(NSUInteger i = 0; i < model.locations.count; i++)
            model.region = [model.region stringByAppendingString:[NSString stringWithFormat:@"%@ ", [[[data objectForKey:@"locations"] objectAtIndex:i]  objectForKey:@"region"]] ];

            
        }else
        {
            model.region = @"";
        }
        
        if (![[data objectForKey:@"class_info"] isKindOfClass:[NSNull class]]) {
            model.classInfo = [data objectForKey:@"class_info"] ;
        }else
        {
            model.classInfo = @"";
        }
        
        
        if (![[data objectForKey:@"cover_image"] isKindOfClass:[NSNull class]]) {
            model.img_cover_url = [NSURL URLWithString:[data objectForKey:@"cover_image"]] ;
        }else
        {
            model.img_cover_url = [NSURL URLWithString:@""];
        }
        
        if (![[data objectForKey:@"hours_per_class"] isKindOfClass:[NSNull class]]) {
            model.hoursPerClass = [data objectForKey:@"hours_per_class"];
           
        }else
        {
            model.hoursPerClass = @0;
        }
        
        if (![[data objectForKey:@"price_per_hour"] isKindOfClass:[NSNull class]]) {
            model.pricePerHour = [data objectForKey:@"price_per_hour"];
          
        }else
        {
            model.hoursPerClass = @0;
        }
        
        if (![[data objectForKey:@"registration_count"] isKindOfClass:[NSNull class]]) {
            model.registrationCount = [data objectForKey:@"registration_count"];
            
        }else
        {
            model.registrationCount = @0;
        }
        
        if (![[data objectForKey:@"min_number_student"] isKindOfClass:[NSNull class]]) {
            model.minNumberStudent = [data objectForKey:@"min_number_student"];
            
        }else
        {
            model.minNumberStudent = @0;
        }
        
        if (![[data objectForKey:@"max_number_student"] isKindOfClass:[NSNull class]]) {
            model.maxNumberStudent = [data objectForKey:@"max_number_student"];
            
        }else
        {
            model.maxNumberStudent = @0;
        }
  
        if (![[data objectForKey:@"number_of_class"] isKindOfClass:[NSNull class]]) {
            model.numberOfClass = [data objectForKey:@"number_of_class"];
            
        }else
        {
            model.numberOfClass = @0;
        }
        
        if (![ [[data objectForKey:@"tutor"] objectForKey:@"profile_image"] isKindOfClass:[NSNull class]]) {
            model.tutorImgURL = [NSURL URLWithString: [[data objectForKey:@"tutor"] objectForKey:@"profile_image"]] ;
        }else
        {
            model.tutorImgURL = [NSURL URLWithString:@""];
        }
        
        if (![ [[data objectForKey:@"tutor"] objectForKey:@"name"] isKindOfClass:[NSNull class]]) {
            model.tutorName = [[data objectForKey:@"tutor"] objectForKey:@"name"] ;
            
        }else
        {
            model.tutorName = @"";
        }
        
        if (![[data objectForKey:@"tutor_message"] isKindOfClass:[NSNull class]]) {
            model.tutorMessage = [data objectForKey:@"tutor_message"] ;
            
        }else
        {
            model.tutorMessage = @"";
        }
        
        if (![[data objectForKey:@"tutor_info"] isKindOfClass:[NSNull class]]) {
            model.tutorInfo = [data objectForKey:@"tutor_info"] ;
            
        }else
        {
            model.tutorInfo = @"";
        }
        
        if (![[data objectForKey:@"class_info"] isKindOfClass:[NSNull class]]) {
            model.classInfo = [data objectForKey:@"class_info"] ;
            
        }else
        {
            model.classInfo = @"";
        }
    }
    
    return model;
}

@end