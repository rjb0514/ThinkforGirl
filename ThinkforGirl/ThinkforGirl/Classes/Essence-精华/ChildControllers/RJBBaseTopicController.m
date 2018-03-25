//
//  RJBBaseTopicController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/19.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBBaseTopicController.h"
#import <UIImageView+WebCache.h>
#import "RJBTopicModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "RJBTopicCell.h"




static NSString *const topicCellIndetifier = @"topic";

@interface RJBBaseTopicController ()


/**
 帖子的个数
 */
@property (nonatomic, strong) NSMutableArray<RJBTopicModel *> *topics;

/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

/** 当加载下一页数字时要加载的东西 */
@property (nonatomic, copy) NSString *maxtime;


@end

@implementation RJBBaseTopicController

//- (NSString *)type {
//    return nil;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RJBTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellIndetifier];
    
    [self setupTableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //加载数据
        [self loadNews];
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreNews];
    }];
    
    NSLog(@"%@",self.view);
    
    
}

- (void)setupTableView {
    //设内边距
    CGFloat top = RJBTitleViewY + RJBTitleViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.contentOffset = CGPointMake(0, -top);
}

#pragma mark - 网络青牛
- (void)loadNews {
    
    
    
    //发请求代码
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"list" forKey:@"a"];
    [params setValue:@"data" forKey:@"c"];
    [params setValue:@(self.type) forKey:@"type"];
    [params setValue:@(self.currentPage) forKey:@"page"];
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary   *responseObject) {
        NSLog(@"%@",responseObject);
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics  = [RJBTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [responseObject writeToFile:@"/Users/ru/Desktop/duanzi.plist" atomically:YES];
        });
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.currentPage = 0;       //上啦 下拉  失败的处理
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
        [self.tableView.mj_header endRefreshing];
    }];
}


/**
 加载更多帖子
 */
- (void)loadMoreNews {
    
    self.currentPage ++;
    //发请求代码
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"list" forKey:@"a"];
    [params setValue:@"data" forKey:@"c"];
    [params setValue:@(self.type) forKey:@"type"];
    [params setValue:@(self.currentPage) forKey:@"page"];
    [params setValue:self.maxtime forKey:@"maxtime"];
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary   *responseObject) {
        NSLog(@"%@",responseObject);
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray<RJBTopicModel *> *topics = [RJBTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:topics];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [responseObject writeToFile:@"/Users/ru/Desktop/duanzi.plist" atomically:YES];
        });
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
        [self.tableView.mj_footer endRefreshing];
        self.currentPage --;
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RJBTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellIndetifier forIndexPath:indexPath];
    cell.model= self.topics[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",NSStringFromCGRect(tableView.frame));
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取出文字的模型
    RJBTopicModel *modle = self.topics[indexPath.row];

    
    return modle.cellHeight;
}


- (NSMutableArray<RJBTopicModel *> *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}


@end



