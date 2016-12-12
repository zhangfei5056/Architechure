//
//  ViewController.m
//  StudyArchitechure
//
//  Created by baidu on 12/8/16.
//  Copyright © 2016 caoyuan. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "CustomTableViewCell.h"
@interface ViewController ()<NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableData *receiveData;
@property (nonatomic, strong) NSArray *hotList;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hotList = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@".hotListArchiver"]];
    [self.tableView reloadData];
    
    self.receiveData = [[NSMutableData alloc]init];
    NSURL *url = [[NSURL alloc]initWithString:@"https://www.v2ex.com/api/topics/hot.json"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
    CGRect frame = [[UIScreen mainScreen]bounds];
    self.tableView = [[UITableView alloc]initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 220;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
}

#pragma mark tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomTableViewCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    __block CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    __weak typeof(self) welf = self;
//    __block UIImage *image = nil;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",welf.hotList[indexPath.row][@"member"][@"avatar_large"]]]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.imageView.image = image;
//            NSString *text = self.hotList[indexPath.row][@"title"];
//            NSString *content = self.hotList[indexPath.row][@"content"];
//            cell.titleLabel.text = text;
//            cell.contentLabel.text = content;
//        });
//    });
    [cell updateCell:self.hotList[indexPath.row]];
    return cell;
}

#pragma mark tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.detailData = self.hotList[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *error = nil;
    self.hotList = [NSJSONSerialization JSONObjectWithData:self.receiveData options:NSJSONReadingAllowFragments error:&error];
    [self.tableView reloadData];
    NSLog(@"hotList\n%@",self.hotList);
    [NSKeyedArchiver archiveRootObject:self.hotList toFile:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@".hotListArchiver"]];
}

@end
