//
//  SegmentControlView.h
//  TitleCollectionView
//
//  Created by 李豪杰 on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SegmentControlView : UIView

@property (copy, nonatomic) NSArray *titleArray;

@property (nonatomic, copy) void(^IndexChangeBlock )(NSInteger index);
/** 设置选中第几个*/
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated ;
@end
