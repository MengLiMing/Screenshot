//
//  WebViewController.m
//  Screenshot
//
//  Created by MengLiMing on 2018/12/25.
//  Copyright © 2018 restone. All rights reserved.
//

#import "WebViewController.h"
#import "Masonry.h"
#import "UIScrollView+MLMSnapshot.h"

@interface WebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截屏" style:UIBarButtonItemStylePlain target:self action:@selector(shotView)];


    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://news.token.im/detail/190?locale=zh-CN&utm_source=imtoken"]]];
}


- (void)shotView {
    self.title = @"正在截图";
    [self.webView.scrollView snapshotCompletion:^(UIImage * _Nonnull image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    self.title = @"截图结束";
    if (!error) {
        NSLog(@"截图成功");
    }
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}


@end
