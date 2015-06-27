//
//  ViewController.m
//  NewsCloud
//
//  Created by Andrew_liu on 15/6/27.
//  Copyright (c) 2015年 Andrew_liu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 菜单栏
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;
// 内容栏
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
// 伪造数据
@property (nonatomic, strong) NSDictionary *dictTitleURL;


@end

@implementation ViewController


#pragma mark - Load

- (void)viewDidLoad {
    [super viewDidLoad];
    // 不自动调整scrollView
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 水平和垂直滑动指示器不可见
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addTableViewControllers];  // 每个title对应一个控制器
    [self addTitleLabel];  // 添加title, 并增加点击事件
    
    self.bigScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, 0);
    self.bigScrollView.pagingEnabled = YES;

    //获得第一个TableViewController
    UITableViewController *mainTableViewController = [self.childViewControllers firstObject];
    mainTableViewController.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:mainTableViewController.view];
    UILabel *title = [self.smallScrollView.subviews firstObject];
    title.textColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

//懒加载title-value字典
- (NSDictionary *)dictTitleURL {
    if (_dictTitleURL == nil) {
        _dictTitleURL = @{@"头条" : @"http://www.baidu.com",
                          @"娱乐" : @"http://www.taobao.com"};
    }
    return _dictTitleURL;
}

- (void)addTableViewControllers {
    for (NSString *title in self.dictTitleURL.allKeys) {
//        NSLog(@"%@", title);
        UITableViewController *tableViewController = [[UITableViewController alloc] init];
        tableViewController.title = title;
        [self addChildViewController:tableViewController];
    }
}

- (void)addTitleLabel {
    int titleLen = [_dictTitleURL.allKeys count];
    NSLog(@"%d", titleLen);
    for (int i = 0; i < titleLen; i++) {
        CGFloat labelW = 70;
        CGFloat labelH = 30;
        CGFloat labelY = 0;
        CGFloat labelX = i * labelW;
        UILabel *title = [[UILabel alloc] init];
        UITableViewController *tableViewController =  self.childViewControllers[i];
        title.font = [UIFont systemFontOfSize:12];
        title.text = tableViewController.title;
        title.textAlignment = NSTextAlignmentCenter;  //居中显示
        NSLog(@"Label :%@, %f, %f, %f, %f", title.text, labelX, labelY, labelW, labelH);
        title.frame = CGRectMake(labelX, labelY, labelW, labelH);
        title.tag = 2000 + i;
        [self.smallScrollView addSubview:title];
    }
    self.smallScrollView.contentSize = CGSizeMake(titleLen * 70, 30);
}


@end
