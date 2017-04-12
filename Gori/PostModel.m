//
//  PostModel.m
//  NetworkProject
//
//  Created by youngmin joo on 2017. 3. 16..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

#import "PostModel.h"

@implementation PostModel

+ (instancetype)modelWithData:(NSDictionary *)data
{
    PostModel *model = [[PostModel alloc] init];
    
    if (data != nil) {
        model.postID = [[data objectForKey:@"pk"] integerValue];
        model.title = [data objectForKey:@"title"];
        
        
        if (![[data objectForKey:@"class_info"] isKindOfClass:[NSNull class]]) {
            model.classInfo = [data objectForKey:@"class_info"] ;
        }else
        {
            model.classInfo = @"";
        }
        
        
        if (![[data objectForKey:@"img_cover"] isKindOfClass:[NSNull class]]) {
            model.img_cover_url = [data objectForKey:@"img_cover"] ;
        }else
        {
            model.img_cover_url = @"";
        }

    }
    
    return model;
}

@end
