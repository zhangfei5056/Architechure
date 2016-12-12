//
//  CustomTableViewCell.h
//  StudyArchitechure
//
//  Created by baidu on 12/9/16.
//  Copyright © 2016 caoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void)updateCell:(NSDictionary *)dict;
@end
