//
//  UIScrollView+MLMSnapshot.m
//  Screenshot
//
//  Created by MengLiMing on 2018/12/25.
//  Copyright © 2018 restone. All rights reserved.
//

#import "UIScrollView+MLMSnapshot.h"

@implementation UIScrollView (MLMSnapshot)

- (void)snapshotCompletion:(void (^)(UIImage * _Nonnull))completion {
    //保存offset
    CGPoint oldContentOffset = self.contentOffset;
    //保存frame
    CGRect oldFrame = self.frame;
    
    if (self.contentSize.height > self.frame.size.height) {
        self.contentOffset = CGPointMake(0, self.contentSize.height - self.frame.size.height);
    }
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    //延迟0.5秒，避免有时候渲染不出来的情况
    [NSThread sleepForTimeInterval:0.5];
    
    self.contentOffset = CGPointZero;
    
    UIImage* snapshotImage = [self screenShot];
    self.frame = oldFrame;
    self.contentOffset = oldContentOffset;
    if (completion) {
        completion(snapshotImage);
    }
    
}

- (UIImage *)screenShot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return shotImage;
}

@end
