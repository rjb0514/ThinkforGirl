//
//  RJBRecommendController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBRecommendController.h"
#import "RJBRecommendTagModel.h"
#import "RJBRecommendTagCell.h"
#import "RJBRecommendUserCell.h"
#import "RJBRecommendUserModel.h"
#import <MJRefresh.h>

@interface RJBRecommendController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *tagModelList;

/** 左边的表格 */
@property (weak, nonatomic) IBOutlet UITableView *tagTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 存储上一次的变量 */
@property (nonatomic, strong) NSMutableDictionary *params;


/** AFN的管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;


@end

@implementation RJBRecommendController

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    
    //注册
    [self.tagTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RJBRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:@"tagCell"];
    
     [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RJBRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:@"userCell"];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"category" forKey:@"a"];
    [dic setValue:@"subscribe" forKey:@"c"];
    
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
      
        
        self.tagModelList = [RJBRecommendTagModel mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"list"]];
        
        NSLog(@"%@",responseObject);
        [self.tagTableView reloadData];
        
        [self.tagTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
    
    
    [self setupRefresh];
    
}


/**
 刷新控件
 */
- (void)setupRefresh {
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewUsers];
    }];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"进入上啦刷新状态");
        [self loadUsers];
  
    }];

}

//下拉加载更多
- (void)loadNewUsers {
    
    NSIndexPath *indexPath = [self.tagTableView indexPathForSelectedRow];
    
    RJBRecommendTagModel *model = self.tagModelList[indexPath.row];
    
    //设置当前页面为1
    model.currentPage = 1;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"list" forKey:@"a"];
    [dic setValue:@"subscribe" forKey:@"c"];
    [dic setValue:model.idString forKey:@"category_id"];
    
    //变请求参数存起来
    self.params = dic;
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        
       
        NSArray *users = [RJBRecommendUserModel mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"list"]];
        //总数
        model.total = [[responseObject objectForKey:@"total"] integerValue];
        
        //先清除之前的旧数据
        [model.users removeAllObjects];
        
        [model.users addObjectsFromArray:users];
        
        if (self.params != dic) {
            return ;
        }
        
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        //检查footer状态
        [self checkFooterState];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != dic) {
            return ;
        }
        NSLog(@"%@",error.description);
        [SVProgressHUD showErrorWithStatus:error.description];
         [self.userTableView.mj_header endRefreshing];
    }];

}

//加载用户数据
- (void)loadUsers {
    
    
    //马上刷新表格：目标不让用户看见上一个数据
    RJBRecommendTagModel *model = self.tagModelList[[self.tagTableView indexPathForSelectedRow].row];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"list" forKey:@"a"];
    [dic setValue:@"subscribe" forKey:@"c"];
    [dic setValue:model.idString forKey:@"category_id"];
    [dic setValue:@(++model.currentPage) forKey:@"page"];
    self.params = dic;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
              //让底部控件结束刷新
        
        NSArray *users = [RJBRecommendUserModel mj_objectArrayWithKeyValuesArray:[responseObject valueForKey:@"list"]];
        [model.users addObjectsFromArray:users];
        
        //可以先处理数据  如果不是这次请求就不刷新数据
        if (self.params != dic) {
            return ;
        }
        
        [self.userTableView reloadData];
        
        if (model.users.count == model.total) {
            //全部加载完毕  提示没有更多数据
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.userTableView.mj_footer endRefreshing];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != dic) {
            return ;
        }
        NSLog(@"%@",error.description);
        [self.userTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:error.description];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tagTableView) {
        return self.tagModelList.count;
    }else {
//        return self.userModelList.count;
        RJBRecommendTagModel *model = self.tagModelList[[self.tagTableView indexPathForSelectedRow].row];
     
        //检查footer状态
        [self checkFooterState];
        
        return model.users.count;
        
    }
}

//检查footer状态
- (void)checkFooterState {
       RJBRecommendTagModel *model = self.tagModelList[[self.tagTableView indexPathForSelectedRow].row];
    
    if (model.users.count == 0) {
        self.userTableView.mj_footer.hidden = YES;
    }else {
        self.userTableView.mj_footer.hidden = NO;
    }
    
    
    if (model.users.count == model.total) {
        //全部加载完毕  提示没有更多数据
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.userTableView.mj_footer endRefreshing];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tagTableView) {
        RJBRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tagCell" forIndexPath:indexPath];
        cell.model = self.tagModelList[indexPath.row];
        return cell;
    }else {
        RJBRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
        RJBRecommendTagModel *model = self.tagModelList[[self.tagTableView indexPathForSelectedRow].row];
        cell.model = model.users[indexPath.row];
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tagTableView == tableView) {
        return 44;
    }else {
        return 70;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    
    if (tableView == self.tagTableView) {
        //先结束刷新
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        
        if ([self.tagModelList[indexPath.row] users].count) {
            [self.userTableView reloadData];
            
        }else {
            
            //马上刷新表格：目标不让用户看见上一个数据
            [self.userTableView reloadData];
            
            //进入下拉刷新状态
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.userTableView.mj_header beginRefreshing];
            });
            
       
        }
    }
    
}



@end
