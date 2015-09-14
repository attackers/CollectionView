//
//  FKCircleLayoutHorizontal.m
//  瀑布流
//
//  Created by attack on 15/9/14.
//  Copyright (c) 2015年 attack. All rights reserved.
//

#import "FKCircleLayoutHorizontal.h"
#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.5
@implementation FKCircleLayoutHorizontal
-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.itemSize = CGSizeMake(154, 300);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(120, 0.0, 120, 0.0);
        self.minimumLineSpacing = 50.0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            if (ABS(distance)<ACTIVE_DISTANCE) {
                CGFloat zoom = 1 + ZOOM_FACTOR * (1 - ABS(distance/ACTIVE_DISTANCE));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = 1;
            }
        }
    }
    return array;
}
@end
