//
//  NSString+Exten.m
//  JYDEbusiness
//
//  Created by 李豪杰 on 15/12/30.
//  Copyright © 2015年 JYD. All rights reserved.
//

#import "NSString+Exten.h"

@implementation NSString (Exten)


// 一般的自适应
- (CGFloat)getStringHeight:(UIFont*)font width:(CGFloat)width
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  font, NSFontAttributeName,
                                  nil];
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, self.length)];
    CGRect stringRect = [attributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       context:nil];
    
    return stringRect.size.height;
}

/** 一般的自适应   返回Size */
- (CGSize)getStringSize:(UIFont*)font width:(CGFloat)width
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  font, NSFontAttributeName,
                                  nil];
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, self.length)];
    CGRect stringRect = [attributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       context:nil];
    
    return stringRect.size;
}


//加入行间距的自适应
- (CGFloat)mutableAttributedStringWithFont:(UIFont *)font
                                    width:(CGFloat)width
                             andLineSpace:(CGFloat)lineSpace
{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  paragraphStyle, NSParagraphStyleAttributeName,
                                  font, NSFontAttributeName,
                                  nil];
    
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, self.length)];
    
    CGRect stringRect = [attributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       context:nil];
    
    return stringRect.size.height;
}
/*
 *设置行间距
 *
 */
+ (NSMutableAttributedString *)setLabelParagraphStyleWithString:(NSString *)changeStr andLineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:changeStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setAlignment:NSTextAlignmentLeft];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [changeStr length])];
    return attributedString;
}



+(NSString *)stringAppendPointformat:(NSString *)num
{
    
    NSNumberFormatter *moneyFormatter = [[NSNumberFormatter alloc] init];
    [moneyFormatter setPositiveFormat:@"###,##0.00;"];
    
    return [moneyFormatter stringFromNumber:[NSNumber numberWithDouble:num.doubleValue]];
}



//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date
{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    NSString *dateString = @"2015-06-26 08:08:08";
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

@end
