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
       model.pk = [data objectForKey:@"pk"];
       model.title = [data objectForKey:@"title"];
       model.locations = [data objectForKey:@"locations"];
       //model.curriculums = [data objectForKey:@"curriculums"];
     
       model.region = [[NSMutableArray alloc] init];
       model.regionsResult = [[NSMutableArray alloc] init];
        if (model.locations.count != 0) {
            for(NSUInteger i = 0; i < model.locations.count; i++) {
                [model.region addObject:[[[data objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"region"]];
                [model.regionsResult addObject:[[[data objectForKey:@"locations"] objectAtIndex:i] objectForKey:@"results"]];
            }
        }
        //[[[model.regionsResult objectAtIndex:0] objectAtIndex:0] objectForKey:@"day"]
        // NSLog(@"[model.regionsResult objectAtIndex:0] day: %@",  [[[model.regionsResult objectAtIndex:0] objectAtIndex:0] objectForKey:@"day"]);
        
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
        
        if (![[data objectForKey:@"curriculums"] isKindOfClass:[NSNull class]]) {
            model.curriculums = [data objectForKey:@"curriculums"] ;
           // NSLog(@"curriculums: %@", [[model.curriculums objectAtIndex:0] objectForKey:@"information"]);
        }else
        {
            model.curriculums = nil;
        }
        
        if (![[data objectForKey:@"location_message"] isKindOfClass:[NSNull class]]) {
            model.locationMessage = [data objectForKey:@"location_message"] ;
            
        }else
        {
            model.locationMessage = @"";
        }
        
        model.userDetail = [data objectForKey:@"user"];
        model.averageRate = [data objectForKey:@"average_rates"];
        model.reviews = [data objectForKey:@"reviews"];
        
        if (![[data objectForKey:@"user"] isKindOfClass:[NSNull class]]) {
             model.userDetail = [data objectForKey:@"user"];
            
        }else
        {
             model.userDetail = nil;
        }
        
        if (![[data objectForKey:@"average_rates"] isKindOfClass:[NSNull class]]) {
            model.averageRate = [data objectForKey:@"average_rates"];
            
        }else
        {
            model.averageRate = nil;
        }
        
        if (![[data objectForKey:@"reviews"] isKindOfClass:[NSNull class]]) {
            model.reviews = [data objectForKey:@"reviews"];
            
        }else
        {
            model.reviews = nil;
        }
    }
    
    return model;
}

@end
