//
//  GOReviewModel.h
//  Gori
//
//  Created by Woncheol on 2017. 4. 22..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOReviewModel : NSObject
@property (nonatomic) NSMutableArray *reviewsContents;

+ (instancetype)modelWithData:(NSDictionary *)data;
@end
