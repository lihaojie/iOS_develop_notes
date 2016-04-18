//
//  SegmentControlView.m
//  TitleCollectionView
//
//  Created by 李豪杰 on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SegmentControlView.h"
#import "SegmentCollectionViewCell.h"
#import "NSString+Exten.h"
@interface SegmentControlView ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *titleCollectionView;

@end

@implementation SegmentControlView
static NSString * const reuseIdentifier = @"MyCollectionViewCell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat itemsH = ([[UIScreen mainScreen] bounds].size.width )/ 4.5;
        flowLayout.itemSize = CGSizeMake(itemsH, self.bounds.size.height);

        self.titleCollectionView = [[UICollectionView  alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:flowLayout];
        
        [self.titleCollectionView registerNib:[UINib nibWithNibName:@"SegmentCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        
        self.titleCollectionView.delegate = self;
        self.titleCollectionView.dataSource = self;
        self.titleCollectionView.bounces = NO;
//        self.titleCollectionView.backgroundColor = [UIColor colorWithHexString:@"#499dfc"];
        self.titleCollectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.titleCollectionView];
    }
    return self;
}

-(NSArray *)titleArray
{
    if (!_titleArray) {
        self.titleArray = [NSArray  array];
        
    }
    return _titleArray;
}
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.titleCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}
#pragma mark - <UICollectionViewDelegate,UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%ld",self.titleArray.count);
    return self.titleArray.count;
}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize itemSize = [self.titleArray[indexPath.row] getStringSize:[UIFont systemFontOfSize:14] width:self.bounds.size.width];
    return CGSizeMake(itemSize.width + 20, itemSize.height + 20);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SegmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.title = self.titleArray[indexPath.row];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.IndexChangeBlock) {
        self.IndexChangeBlock(indexPath.row);
    }
    [self.titleCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end
