//
//  GOReviewModel.m
//  Gori
//
//  Created by Woncheol on 2017. 4. 22..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import "GOReviewModel.h"

@implementation GOReviewModel
+ (instancetype)modelWithData:(NSDictionary *)data
{
    GOReviewModel *model = [[GOReviewModel alloc] init];
    
    if (data != nil) {
        model.reviewsContents = [data objectForKey:@"results"];
    }
    
    return model;
}
@end
