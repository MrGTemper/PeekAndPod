//
//  ViewController.m
//  3DTouch
//
//  Created by Erwin on 16/4/28.
//  Copyright © 2016年 Erwin. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSIndexPath *indexPath;
@property (nonatomic, assign) CGRect sourceRect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    self.dataSource = @[@"测试数据1",@"测试数据2",@"测试数据3",@"测试数据4",@"测试数据5",@"测试数据6",@"测试数据7",@"测试数据8",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",@"测试数据1",];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    
    self.table.delegate = self;
    self.table.dataSource = self;

    [self.table reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.indexPath = indexPath;
    DetailViewController *contentVC = [[DetailViewController alloc] init];
    contentVC.text = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:contentVC animated:YES];
}

#pragma mark pop
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    
    [self tableView:self.table didSelectRowAtIndexPath:self.indexPath];
    
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    //防止重复加入
    if ([self.presentedViewController isKindOfClass:[DetailViewController class]]){
        return nil;
    }
    else {
        
        CGPoint p = [self.table convertPoint:location toView:self.view];
        
        NSIndexPath *indexpath = [self.table indexPathForRowAtPoint:p];
        
        // 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。
        if (![self getShouldShowRectAndIndexPathWithLocation:location]) return nil;
        
        previewingContext.sourceRect = self.sourceRect;

        DetailViewController *contentVC = [[DetailViewController alloc] init];
        contentVC.text = self.dataSource[self.indexPath.row];
        return contentVC;
    }
}

/** 获取用户手势点所在cell的下标。同时判断手势点是否超出tableView响应范围。*/
- (BOOL)getShouldShowRectAndIndexPathWithLocation:(CGPoint)location {
    NSInteger row = (location.y - 64)/50;
    self.sourceRect = CGRectMake(0, row * 50 + 64, [UIScreen mainScreen].bounds.size.width, 50);
    self.indexPath = [NSIndexPath indexPathForItem:row inSection:0];
    // 如果row越界了，返回NO 不处理peek手势
    return row >= self.dataSource.count ? NO : YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
