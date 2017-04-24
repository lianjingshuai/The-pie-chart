//
//  ScoreView.m
//  PolygonScore
//
//  Created by 周俊杰 on 15/7/14.
//  Copyright (c) 2015年 北京金溪欣网络科技有限公司. All rights reserved.
//
#define spaceDegree (2*M_PI/_sideCount)
#import "ScoreView.h"

@interface ScoreView ()

@property (nonatomic, assign) int sideCount;
@property (nonatomic, assign) int radiusLong;
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) NSArray *textArray;
@end

@implementation ScoreView

- (instancetype)initWithFrame:(CGRect)frame InfoArray:(NSArray *)infoArray TextArray:(NSArray *)textArray{
//    self = [super init];
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    if (self) {
        if ([infoArray count]<3 || [infoArray count] > 10) {
            NSLog(@"多边形不满足");
            return nil;
        }
        for (NSDictionary *infoDic in infoArray) {
            float value = [[infoDic allValues][0] floatValue];
            if (value < 0 || value > 1) {
                NSLog(@"数据错误 数值传0-1");
                return nil;
            }
        }
//        self.frame = [UIScreen mainScreen].bounds;
        _infoArray = infoArray;
        _textArray = textArray;
        _sideCount = (int)infoArray.count;
        _radiusLong = 100;
        [self drawScoreView];
    }
    return self;
}

- (void)drawScoreView {
    [self drawBackground];
    [self drawScore];
}

- (void)drawBackground {
    [self drawWithPointsArray:[self pointsAtSide:YES] isBackground:NO];
}

- (void)drawScore {
    [self drawWithPointsArray:[self pointsAtSide:NO] isBackground:YES];
}

// 这个方法被调用了两侧   第一次是下面那个不规则图形   第二次是上面那个多边形
- (void)drawWithPointsArray:(NSArray *)pointsArray isBackground:(BOOL)isBackground {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    for (int i = 0; i < pointsArray.count; i++) {
        if (i == 0) {
            [aPath moveToPoint:CGPointFromString(pointsArray[i])];
        }else {
            [aPath addLineToPoint:CGPointFromString(pointsArray[i])];
        }
        
        
        #warning 根据for循环画了这个几个三角形👇👇👇👇👇👇👇
        CAShapeLayer *shapeLayer123 = [CAShapeLayer layer];
        UIBezierPath* aPath123 = [UIBezierPath bezierPath];
        [aPath123 moveToPoint:CGPointFromString(pointsArray[i])]; // 起始点
        if (i+1 == pointsArray.count) {
            [aPath123 addLineToPoint:CGPointFromString(pointsArray[0])]; // 第二个点
        }else {
            [aPath123 addLineToPoint:CGPointFromString(pointsArray[i+1])];
        }
        [aPath123 addLineToPoint:CGPointFromString(NSStringFromCGPoint(CGPointMake(self.center.x,self.center.y)))]; // 第三个点
        [aPath123 closePath]; // 关闭路径
        shapeLayer123.lineWidth = 0.3; // 边框宽
        shapeLayer123.path = aPath123.CGPath;
        shapeLayer123.strokeColor = [[UIColor colorWithWhite:0.500 alpha:1.000] CGColor]; // 边框颜色
        shapeLayer123.fillColor = [[UIColor clearColor] CGColor]; // 内部颜色
        [self.layer addSublayer:shapeLayer123]; // 这就相当于添加上去
        #warning 根据for循环画了这个几个三角形👆👆👆👆👆👆👆
        
        
        
        #warning 根据for循环画了这个几个label👇👇👇👇👇👇👇
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 40)]; // 在这里位置没用的，因为下面又重置了
        label.font = [UIFont systemFontOfSize:11]; // 设置label内容颜色
        label.textAlignment = NSTextAlignmentCenter; // 内容居中
        label.text = _textArray[i]; // 添加内容
        label.textColor = [UIColor colorWithWhite:0.500 alpha:1.000]; // 内容颜色
        label.center = CGPointMake(self.center.x-(_radiusLong +20)*cos(spaceDegree*i + M_PI_2),self.center.y-(_radiusLong +20)*sin(spaceDegree*i + M_PI_2)); // 把这个位置给了label中心
        [self addSubview:label]; // 添加到view上
        #warning 根据for循环画了这个几个label👆👆👆👆👆👆👆
        
        
        if (i == pointsArray.count-1) {
            [aPath closePath];
            
            if (isBackground) {
                shapeLayer.lineWidth = 0.3;
            }
            else{
                shapeLayer.lineWidth = 0;
            }
            
            shapeLayer.path = aPath.CGPath;
            shapeLayer.strokeColor = [[UIColor colorWithWhite:0.500 alpha:1.000] CGColor];
            shapeLayer.fillColor = isBackground?[[UIColor clearColor] CGColor]:[[UIColor colorWithRed:0.580 green:0.890 blue:0.593 alpha:1.000] CGColor];
            
            [self.layer addSublayer:shapeLayer];
        }
    }

}

- (NSArray *)pointsAtSide:(BOOL)isSide {
    NSMutableArray *resultArray = @[].mutableCopy;
    for (int i = 0; i < _sideCount; i ++) {
        float pointDegree = spaceDegree*i + M_PI_2;
        int radius = _radiusLong;
        NSDictionary *infoDic = _infoArray[i];
        if (isSide) {
            float value = [[infoDic allValues][0] floatValue];
            radius = value*_radiusLong;
        }
        NSLog(@"xxxx:%f  yyyy:%f",self.center.x,self.center.y);
        CGPoint acmePoint = CGPointMake(self.center.x-radius*cos(pointDegree),self.center.y-radius*sin(pointDegree));
        [resultArray addObject:NSStringFromCGPoint(acmePoint)];
    }
    return [[NSArray alloc] initWithArray:resultArray];
}
@end
