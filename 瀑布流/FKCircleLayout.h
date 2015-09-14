//
//  FKCircleLayout.h
//  瀑布流
//
//  Created by attack on 15/9/14.
//  Copyright (c) 2015年 attack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKCircleLayout : UICollectionViewLayout
@property (nonatomic,assign) CGPoint center;
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) NSInteger cellCount;
@end
