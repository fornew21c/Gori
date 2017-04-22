//
//  GOReviewTableTableViewCell.h
//  Gori
//
//  Created by Woncheol on 2017. 4. 22..
//  Copyright © 2017년 fornew21c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GOReviewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *reviewerImage;
@property (weak, nonatomic) IBOutlet UILabel *reviewerName;
@property (weak, nonatomic) IBOutlet UILabel *reviewerCreateDate;
@property (weak, nonatomic) IBOutlet UITextView *reviewCommnet;

@end
