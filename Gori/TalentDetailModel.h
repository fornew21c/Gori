//
//  PostModel.h
//  NetworkProject
//
//  Created by youngmin joo on 2017. 3. 16..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "pk": 23,
 "title": "Post with Image",
 "img_cover": "http://127.0.0.1:8000/media/post/120_qaXrLMD.png",
 "content": "Post Content"
 */

@interface TalentDetailModel : NSObject

@property (nonatomic) NSInteger postID;
@property (nonatomic) NSString *title;
@property (nonatomic) NSMutableArray *locations;
@property (nonatomic) NSString *region;
@property (nonatomic) NSInteger *hoursPerClass;
@property (nonatomic) NSString *classInfo;
@property (nonatomic) NSURL *img_cover_url;


+ (instancetype)modelWithData:(NSDictionary *)data;



@end
