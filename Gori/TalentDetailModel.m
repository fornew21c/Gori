//
//  PostModel.m
//  NetworkProject
//
//  Created by youngmin joo on 2017. 3. 16..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

#import "TalentDetailModel.h"

@implementation TalentDetailModel

+ (instancetype)modelWithData:(NSDictionary *)data
{
    TalentDetailModel *model = [[TalentDetailModel alloc] init];
    
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
//            model.hoursPerClass = [data objectForKey:@"hours_per_class"];
//            NSLog(@"%lu", model.hoursPerClass);
        }else
        {
            model.hoursPerClass = 0;
        }

    }
    
    return model;
}

@end
