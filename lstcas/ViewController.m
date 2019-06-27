//
//  ViewController.m
//  lstcas
//
//  Created by fwj on 2019/6/27.
//  Copyright © 2019年 ls. All rights reserved.
//

#import "ViewController.h"
#import "LSTCModel.h"
#import "LSCardNode.h"

@interface ViewController ()<ASTableDelegate,ASTableDataSource>

@property (nonatomic, strong)ASTableNode *tableNode;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation ViewController

//reloadData会闪

- (instancetype)init{
    _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    _tableNode.view.estimatedRowHeight = 0;//避免滑动时掉帧
    self = [super initWithNode:_tableNode];
    if (self) {
        _tableNode.delegate = self;
        _tableNode.dataSource = self;
    }
    return self;
}

- (void)dealloc{
    _tableNode.delegate = nil;
    _tableNode.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableNode.leadingScreensForBatching = 1.0;
    [self.view addSubnode:self.tableNode];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableNode.frame = self.view.bounds;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    LSTCModel *tcmodel = self.dataSource[indexPath.row];
    return ^{
        LSCardNode *cardNode = [[LSCardNode alloc] initWithTcmodel:tcmodel];
        return cardNode;
    };
}

- (ASSizeRange)tableNode:(ASTableNode *)tableNode constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGSize minSize = CGSizeMake(width, 100);
    CGSize maxSize = CGSizeMake(width, INFINITY);
    return ASSizeRangeMake(minSize, maxSize);
}

//预加载
- (BOOL)shouldBatchFetchForTableNode:(ASTableNode *)tableNode{
    return YES;
}

- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    [context beginBatchFetching];
    
    //加载数据
    
    
    [context completeBatchFetching:YES];
}

#pragma mark - loadData
- (void)loadData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=PCgame" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"error"] integerValue] ==0) {
                self.dataSource = [LSTCModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
    }];
}

@end
