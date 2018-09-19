//
//  ZDNavigationHelper.h
//  ZDNavigationController
//
//  Created by Zero.D.Saber on 2018/9/19.
//  Copyright © 2018年 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, ZDPopGestureOrientation) {
    ZDPopGestureOrientationLeftToRight  = 1 << 0,
    ZDPopGestureOrientationTopToBottom  = 1 << 1,
    ZDPopGestureOrientationDefault  = ZDPopGestureOrientationLeftToRight,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZDNavigationHelper : NSObject

@end

NS_ASSUME_NONNULL_END
