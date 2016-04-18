//
//  SegmentCollectionViewCell.m
//  TitleCollectionView
//
//  Created by 李豪杰 on 16/4/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SegmentCollectionViewCell.h"

@interface SegmentCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation SegmentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.titleLab.textColor = selected ? [UIColor greenColor] :[UIColor whiteColor] ;
//    self.imageV.image = selected ? [UIImage imageNamed:@"order_seg_2_select"] : nil;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text = title;
}

@end
