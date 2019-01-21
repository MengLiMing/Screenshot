//
//  WKWebView+MLMSnapshot.h
//  Screenshot
//
//  Created by MengLiMing on 2018/12/25.
//  Copyright © 2018 restone. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (MLMSnapshot)

- (void)snapshotCompletion:(void(^)(UIImage *image))completion;

@end

NS_ASSUME_NONNULL_END
