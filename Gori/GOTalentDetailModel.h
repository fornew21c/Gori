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

@interface GOTalentDetailModel : NSObject

@property (nonatomic) BOOL alreadyDetailViewInYN; //수업신청하기위해 로그인한 경우 바로 디테일뷰 화면으로 가기위한 BOOL변수
@property (nonatomic) BOOL newReviewRegisterYN;
@property (nonatomic) NSInteger postID;
@property (nonatomic) NSNumber *pk;
@property (nonatomic) NSString *title;
@property (nonatomic) NSURL *img_cover_url;
@property (nonatomic) NSMutableArray *locations;
@property (nonatomic) NSMutableArray *regionsResult;
@property (nonatomic) NSMutableArray *region;
@property (nonatomic) NSNumber *hoursPerClass;
@property (nonatomic) NSNumber *pricePerHour;
@property (nonatomic) NSNumber *registrationCount;
@property (nonatomic) NSNumber *minNumberStudent;
@property (nonatomic) NSNumber *maxNumberStudent;
@property (nonatomic) NSNumber *numberOfClass;
@property (nonatomic) NSURL *tutorImgURL;
@property (nonatomic) NSString *tutorName;
@property (nonatomic) NSString *tutorMessage;
@property (nonatomic) NSString *tutorInfo;
@property (nonatomic) NSMutableDictionary *regions;
@property (nonatomic) NSString *classInfo;
@property (nonatomic) NSString *locationMessage;
@property (nonatomic) NSMutableDictionary *userDetail;
@property (nonatomic) NSMutableDictionary *averageRate;
@property (nonatomic) NSMutableArray *curriculums;
@property (nonatomic) NSMutableArray *reviews;

@property (nonatomic) NSString *test;


+ (instancetype)modelWithData:(NSDictionary *)data;



@end
