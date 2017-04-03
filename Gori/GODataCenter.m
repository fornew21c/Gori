//
//  DataCenter.m
//  Gori
//
//  Created by ji jun young on 2017. 3. 29..
//  Copyright © 2017년 Fastcampus. All rights reserved.
//

#import "GODataCenter.h"

@implementation GODataCenter

+(instancetype)sharedInstance{
    static GODataCenter *dataCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataCenter = [[self alloc]init];
    });
    return dataCenter;
}

/**************** setting for MainView ********************************/

-(NSArray *)settingTutorNameArray{
    /**************** temporary Array for tableviewCell Setting ********************************/
//    NSArray *tutorNameArray = @[@"1지준영", @"2허원철", @"3박재한", @"4박종찬", @"5최제헌", @"6정한선", @"7홍정기"];
//    self.tutorNameArray = tutorNameArray;
//    return self.tutorNameArray;
    NSArray *tutorNameArray = [[NSArray alloc]initWithObjects:@"1지준영", @"2허원철", @"3박재한", @"4박종찬", @"5최제헌", @"6정한선", @"7홍정기", @"8조봉기", nil];
    self.tutorNameArray = tutorNameArray;
    return self.tutorNameArray;
}

-(NSArray *)settingTitleArray{
    /**************** temporary Array for tableviewCell Setting ********************************/
//    NSArray *titleArray = @[@"1당신도 오브젝티브씨 고수가 될 수 있엉", @"2두달에 안드로이드 정복하기", @"3인테리어 디자이너와 함께 하는 프론트엔드 개론", @"4UX디자이너와 함께 하는 UI디자인 4주과정", @"5사년만 공부하면 너도 TED 연사급 iOS개발자", @"6반년안에 끝내는 언리얼엔진 게임개발", @"7유니티로 하는 4주안에 RPG게임 만들기"];
//    self.titleArray = titleArray;
//    return self.titleArray;
    NSArray *titleArray = [[NSArray alloc]initWithObjects:@"1당신도 오브젝티브씨 고수가 될 수 있엉", @"2두달에 안드로이드 정복하기", @"3디자이너와 함께 하는 프론트엔드 개론", @"4UX디자이너와 함께 하는 UI디자인 4주과정", @"5사년만 공부하면 너도 TED 연사급 iOS개발자", @"6반년안에 끝내는 언리얼엔진 게임개발",@"77주만 노력하면 너도 풀스텍", @"8너도나도 할 수 있는 풀스텍 도전기", nil];
        self.titleArray = titleArray;
        return self.titleArray;
}

/**************** setting for Location and Class Category ********************************/

- (NSArray *)settingCategoryArray{
    /**************** temporary Array for collectionviewCell Setting ********************************/
    NSArray *categoryArray = @[@"전체", @"헬스&뷰티", @"외국어", @"컴퓨터", @"음악&미술", @"스포츠", @"전공&취업", @"이색취미"];
    self.categoryArray = categoryArray;
    return  self.categoryArray;
}

- (NSArray *)settingCategoryDetailArray{
    /**************** temporary Array for collectionviewCell Setting ********************************/
    NSArray *categoryDetailArray = @[@"", @"헬스PT, 필라테스, 요가, 메이크업", @"외국어시험, 영어회화, 중국어", @"프로그래밍, 엑셀, 피피티", @"기타, 피아노, 미술", @"방송댄스, 구기운동, 스케이트보드", @"주식투자, 자기소개서, 학과전공", @"사진, 캘리그래피, 바둑"];
    self.categoryDetailArray = categoryDetailArray;
    return  self.categoryDetailArray;
}


- (NSArray *)settingSchoolLocationArray{
    /**************** temporary Array for collectionviewCell Setting ********************************/
    NSArray *schoolLocationArray = @[@"전체", @"고려대", @"연세대", @"이화여대", @"서울대", @"부산대", @"중앙대"];
    self.schoolLocationArray = schoolLocationArray;
    return self.schoolLocationArray;
}












@end
