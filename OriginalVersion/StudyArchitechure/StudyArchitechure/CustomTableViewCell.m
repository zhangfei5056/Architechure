//
//  CustomTableViewCell.m
//  StudyArchitechure
//
//  Created by baidu on 12/9/16.
//  Copyright © 2016 caoyuan. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateCell:(NSDictionary *)dict {
//    [self performSelector:@selector(realUpdate:) withObject:dict afterDelay:0 inModes:@[NSDefaultRunLoopMode, UITrackingRunLoopMode]];
    [self performSelector:@selector(realUpdate:) withObject:dict afterDelay:0 inModes:@[UITrackingRunLoopMode]];
}


- (void)realUpdate:(NSDictionary *)dict {
    self.titleLabel.text = dict[@"title"];
    self.contentLabel.text  = dict[@"content"];
    __block UIImage *image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",dict[@"member"][@"avatar_large"]]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                self.avatarImageview.image = image;
            }
        });
    });
}
@end
