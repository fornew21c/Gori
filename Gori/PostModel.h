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

@interface PostModel : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *classInfo;
@property (nonatomic) NSString *img_cover_url;
@property (nonatomic) NSInteger postID;

+ (instancetype)modelWithData:(NSDictionary *)data;



@end
