//
//  MyChildViewController.m
//  ScrollView 二图
//
//  Created by 李豪杰 on 16/4/15.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyChildViewController.h"
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RandomColor RGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
@interface MyChildViewController ()
@property (assign, nonatomic) NSInteger  lastIndex;

@property (strong, nonatomic) UILabel *label;

@end

@implementation MyChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    self.view.backgroundColor = RandomColor;
    // Do any additional setup after loading the view.
    
    
    
}


-(void)setTag:(NSInteger)tag{
    _tag = tag;
    if (self.lastIndex != tag) {
        self.lastIndex = tag;
        self.view.backgroundColor = RandomColor;
    }
    if (!self.label) {
        self.label = [UILabel new];
        _label.frame = CGRectMake(50, 200, 250, 50);
        [self.view addSubview:self.label];
    }
    self.label.backgroundColor = RandomColor;
    self.label.text = [NSString stringWithFormat:@"这个是 第%ld 个 Label",self.tag];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
