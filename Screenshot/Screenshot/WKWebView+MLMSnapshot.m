//
//  WKWebView+MLMSnapshot.m
//  Screenshot
//
//  Created by MengLiMing on 2018/12/25.
//  Copyright © 2018 restone. All rights reserved.
//

#import "WKWebView+MLMSnapshot.h"

@implementation WKWebView (MLMSnapshot)

- (void)snapshotCompletion:(void(^)(UIImage *image))completion {
    UIView *oldSuperView = self.superview;
    
    CGRect oldFrame = self.frame;
    CGPoint oldOffset = self.scrollView.contentOffset;
    CGSize contentSize = self.scrollView.contentSize;
    
    //添加遮罩
    UIView *snapShotView = [self snapshotViewAfterScreenUpdates:YES];
    snapShotView.frame = oldFrame;
    [oldSuperView addSubview:snapShotView];
    
    //设置frame为contentsize
    self.scrollView.contentOffset = CGPointZero;
    
    UIGraphicsBeginImageContextWithOptions(contentSize, NO, [UIScreen mainScreen].scale);
    
    __weak typeof(self) weakSelf = self;
    [self snopStartOriginY:0 singleHeight:self.bounds.size.height totalHeight:contentSize.height finishBlock:^{
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        weakSelf.scrollView.contentOffset = oldOffset;
        
        [snapShotView removeFromSuperview];

        if (completion) {
            completion(snapshotImage);
        }
    }];
    
}

- (void)snopStartOriginY:(CGFloat)originY singleHeight:(CGFloat)singleHeight totalHeight:(CGFloat)totalHeight finishBlock:(void(^)(void))finishBlock {
    
    CGRect snapFrame = CGRectMake(0, originY, self.bounds.size.width, singleHeight);
    
    CGPoint point = self.scrollView.contentOffset;
    point.y = originY;
    self.scrollView.contentOffset = point;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self drawViewHierarchyInRect:snapFrame afterScreenUpdates:YES];
        
        CGFloat nextOriginY = originY + singleHeight;
        if (nextOriginY < totalHeight) {
            [self snopStartOriginY:nextOriginY singleHeight:singleHeight totalHeight:totalHeight finishBlock:finishBlock];
        } else {
            if (finishBlock) {
                finishBlock();
            }
        }
    });
}




@end
