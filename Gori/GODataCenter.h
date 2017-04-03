//
//  DataCenter.h
//  Gori
//
//  Created by ji jun young on 2017. 3. 29..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GODataCenter : NSObject

/**************** temporary Array for tableviewCell Setting ********************************/
@property (nonatomic) NSArray *titleArray;
@property (nonatomic) NSArray *tutorNameArray;
@property (nonatomic) NSArray *categoryArray;
@property (nonatomic) NSArray *categoryDetailArray;
@property (nonatomic) NSArray *schoolLocationArray;
@property (nonatomic) NSArray *districtLoactionArray;

@property (nonatomic) NSInteger currentRow;

+ (instancetype)sharedInstance;
- (NSArray *)settingTitleArray;
- (NSArray *)settingTutorNameArray;
- (NSArray *)settingCategoryArray;
- (NSArray *)settingCategoryDetailArray;
- (NSArray *)settingSchoolLocationArray;
- (NSArray *)settingDistrictLocationArray;

@end
