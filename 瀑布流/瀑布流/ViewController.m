//
//  ViewController.m
//  瀑布流
//
//  Created by attack on 15/9/14.
//  Copyright (c) 2015年 attack. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "FKCircleLayout.h"
#import "FKCircleLayoutHorizontal.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *collerV;
    UICollectionViewFlowLayout *fLayout;
    NSInteger cellCount;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLaout];
    cellCount = 24;
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)initLaout
{

    FKCircleLayout *circlelayout = [[FKCircleLayout alloc]init];

    FKCircleLayoutHorizontal *horizontal = [[FKCircleLayoutHorizontal alloc]init];
    collerV = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:horizontal];
    [collerV registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    collerV.delegate = self;
    collerV.dataSource = self;
    [self.view addSubview:collerV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [collerV addGestureRecognizer:tap];

}
- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint initialPinchPoint = [sender locationInView:collerV];
        NSIndexPath *tappedCellPath = [collerV indexPathForItemAtPoint:initialPinchPoint];
        if (tappedCellPath) {
            cellCount--;
            [collerV deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
        }else{
        
            cellCount++;
            [collerV insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
        }
    }

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return cellCount;

}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
