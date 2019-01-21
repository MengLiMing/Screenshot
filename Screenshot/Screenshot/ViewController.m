//
//  ViewController.m
//  Screenshot
//
//  Created by MengLiMing on 2018/12/25.
//  Copyright © 2018 restone. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import "WKWebView+MLMSnapshot.h"

@interface ViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"截屏" style:UIBarButtonItemStylePlain target:self action:@selector(shotView)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"webview" style:UIBarButtonItemStylePlain target:self action:@selector(loadurl)];

    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://news.token.im/detail/190?locale=zh-CN&utm_source=imtoken"]]];
}

- (void)loadurl {
    [self.navigationController pushViewController:[NSClassFromString(@"WebViewController") new] animated:YES];
}

- (void)shotView {
    self.title = @"正在截图";
    
    [self.webView snapshotCompletion:^(UIImage * _Nonnull image) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    self.title = @"截图结束";
    if (!error) {
        NSLog(@"截图成功");
    }
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
    }
    return _webView;
}


@end
