//
//  DetailViewController.m
//  StudyArchitechure
//
//  Created by baidu on 12/8/16.
//  Copyright © 2016 caoyuan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.detailData[@"title"];
}

@end
