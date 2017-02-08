//
//  view.m
//  tabbar
//
//  Created by hgy on 16/1/24.
//  Copyright © 2016年 hgy. All rights reserved.
//

#import "GYWaterView.h"
#import "UIView+Extension.h"
@interface GYWaterView ()
{
    
    
    
    
    float a;
    float b;
    
    BOOL jia;
}
@end


@implementation GYWaterView
- (void)setM:(CGFloat)m
{
    _m = m;
    
}
- (void)setCurrentcolor:(UIColor *)currentcolor
{
    
    _currentcolor = currentcolor;
    
}
- (void)setCurrentLinePointY:(CGFloat)currentLinePointY
{
    
    _currentLinePointY = currentLinePointY;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        a = 1.5;
        b = 0;
        jia = NO;
        _currentLinePointY = 75;
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

-(void)animateWave
{
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    
    b+=0.1;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [self.currentcolor CGColor]);
    
    float y = _currentLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    CGFloat width = self.bounds.size.width;
    for(float x=0;x<=width;x++){
        y= a * sin( x/180*M_PI + 4*b/M_PI + _m) * 3 + _currentLinePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, width, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, y);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    
}


@end
