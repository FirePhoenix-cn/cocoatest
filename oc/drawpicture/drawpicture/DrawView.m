//
//  DrawView.m
//  drawpicture
//
//  Created by jinou on 16/8/19.
//  Copyright © 2016年 com.jinou.phoenixlock. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


//类方法重写,绘制自定义图形到屏幕

-(void)drawRect:(CGRect)rect
{
    [self drawLinearGradient:UIGraphicsGetCurrentContext()];
}

//几何图形绘制
-(void)drawLine1
{
    //1.取得图形上下文对象
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.创建路径对象
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 50);//移动到指定位置（设置路径起点）
    CGPathAddLineToPoint(path, nil, 20, 100);//绘制直线（从起始位置开始）
    CGPathAddLineToPoint(path, nil, 300, 100);//绘制另外一条直线（从上一直线终点开始绘制）
    
    //3.添加路径到图形上下文
    CGContextAddPath(context, path);
    
    //4.设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
    CGContextSetLineWidth(context, 2.0);//设置线条宽度
    CGContextSetLineCap(context, kCGLineCapRound);//设置顶点样式,（20,50）和（300,100）是顶点
    CGContextSetLineJoin(context, kCGLineJoinRound);//设置连接点样式，(20,100)是连接点
    /*设置线段样式
     phase:虚线开始的位置
     lengths:虚线长度间隔（例如下面的定义说明第一条线段长度8，然后间隔3重新绘制8点的长度线段，当然这个数组可以定义更多元素）
     count:虚线数组元素个数
     */
    CGFloat lengths[2] = { 18, 9 };
    CGContextSetLineDash(context, 0, lengths, 2);
    /*设置阴影
     context:图形上下文
     offset:偏移量
     blur:模糊度
     color:阴影颜色
     */
    CGColorRef color = [UIColor grayColor].CGColor;//颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color);
    
    //5.绘制图像到指定图形上下文
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);//最后一个参数是填充类型
    
    //6.释放对象
    CGPathRelease(path);
}


//此处是相对与上面的方法的进一步封装
-(void)drawLine2{
    //1.获得图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //2.绘制路径（相当于前面创建路径并添加路径到图形上下文两步操作）
    CGContextMoveToPoint(context, 20, 50);
    CGContextAddLineToPoint(context, 20, 100);
    CGContextAddLineToPoint(context, 300, 100);
    //封闭路径:a.创建一条起点和终点的线,不推荐
    //CGPathAddLineToPoint(path, nil, 20, 50);
    //封闭路径:b.直接调用路径封闭方法
    CGContextClosePath(context);
    
    //3.设置图形上下文属性
    [[UIColor redColor]setStroke];//设置红色边框
    [[UIColor greenColor]setFill];//设置绿色填充
    //[[UIColor blueColor]set];//同时设置填充和边框色
    
    //4.绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
}



//绘制贝塞尔曲线
-(void)drawCurve:(CGContextRef)context{
    
    //绘制曲线
    CGContextMoveToPoint(context, 20, 100);//移动到起始位置
    /*绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddQuadCurveToPoint(context, 160, 0, 300, 100);
    
    CGContextMoveToPoint(context, 20, 500);
    /*绘制三次贝塞尔曲线
     c:图形上下文
     cp1x:第一个控制点x坐标
     cp1y:第一个控制点y坐标
     cp2x:第二个控制点x坐标
     cp2y:第二个控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddCurveToPoint(context, 80, 300, 240, 500, 300, 300);
    
    //设置图形上下文属性
    [[UIColor yellowColor]setFill];
    [[UIColor redColor]setStroke];
    
    
    //绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    
}



//文字绘制
-(void)drawText:(CGContextRef)context{
    //绘制到指定的区域内容
    NSString *str=@"Star Walk is the most beautiful stargazing app you’ve ever seen on a mobile device. It will become your go-to interactive astro guide to the night sky, following your every movement in real-time and allowing you to explore over 200, 000 celestial bodies with extensive information about stars and constellations that you find.";
    CGRect rect= CGRectMake(20, 50, 280, 300);
    UIFont *font=[UIFont systemFontOfSize:18];//设置字体
    UIColor *color=[UIColor redColor];//字体颜色
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];//段落样式
    NSTextAlignment align=NSTextAlignmentLeft;//对齐方式
    style.alignment=align;
    [str drawInRect:rect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
}


//图像绘制
-(void)drawImage:(CGContextRef)context{
    UIImage *image=[UIImage imageNamed:@"meinv.jpg"];
    //从某一点开始绘制
    [image drawAtPoint:CGPointMake(10, 50)];
    //绘制到指定的矩形中，注意如果大小不合适会会进行拉伸
    //    [image drawInRect:CGRectMake(10, 50, 300, 450)];
    //平铺绘制
    //    [image drawAsPatternInRect:CGRectMake(0, 0, 320, 568)];
}



//绘制渐变填充
//a.线性渐变线：渐变色以直线方式从开始位置逐渐向结束位置渐变
//b.径向渐变：以中心点为圆心从起始渐变色向四周辐射，直到终止渐变色

-(void)drawLinearGradient:(CGContextRef)context{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制线性渐变
     context:图形上下文
     gradient:渐变色
     startPoint:起始位置
     endPoint:终止位置
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
     */
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(320, 300), kCGGradientDrawsAfterEndLocation);
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}

-(void)drawRadialGradient:(CGContextRef)context{
    //使用rgb颜色空间
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    /*绘制径向渐变
     context:图形上下文
     gradient:渐变色
     startCenter:起始点位置
     startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
     endCenter:终点位置（通常和起始点相同，否则会有偏移）
     endRadius:终点半径（也就是渐变的扩散长度）
     options:绘制方式,kCGGradientDrawsBeforeStartLocation 开始位置之前就进行绘制，但是到结束位置之后不再绘制，
     kCGGradientDrawsAfterEndLocation开始位置之前不进行绘制，但到结束点之后继续填充
     */
    CGContextDrawRadialGradient(context, gradient, CGPointMake(160, 284),0, CGPointMake(165, 289), 150, kCGGradientDrawsAfterEndLocation);
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}


//渐变填充

/*
 上面我们只是绘制渐变到图形上下文，实际开发中有时候我们还需要填充对应的渐变色，例如现在绘制了一个矩形，如何填充成渐变色呢？在此可以利用渐变裁切来完成（当然利用层CALayer更加方便但这不在今天的话题讨论范围内），特别说明一下区域裁切并不仅仅适用于渐变填充，对于其他图形绘制仍然适用，并且注意裁切只能限于矩形裁切。
 */
-(void)drawRectWithLinearGradientFill:(CGContextRef)context{
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    //裁切处一块矩形用于显示，注意必须先裁切再调用渐变
    //CGContextClipToRect(context, CGRectMake(20, 50, 280, 300));
    //裁切还可以使用UIKit中对应的方法
    UIRectClip(CGRectMake(20, 50, 280, 300));
    
    CGFloat compoents[12]={
        248.0/255.0,86.0/255.0,86.0/255.0,1,
        249.0/255.0,127.0/255.0,127.0/255.0,1,
        1.0,1.0,1.0,1.0
    };
    CGFloat locations[3]={0,0.3,1.0};
    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
    
    CGContextDrawLinearGradient(context, gradient, CGPointMake(20, 50), CGPointMake(300, 300), kCGGradientDrawsAfterEndLocation);
    
    
    //释放颜色空间
    CGColorSpaceRelease(colorSpace);
}

/*
 使用Quartz 2D绘图时后面绘制的图像会覆盖前面的，默认情况下如果前面的被覆盖后将看不到后面的内容，但是有时候这个结果并不是我们想要的，因此在Quartz 2D中提供了填充模式供开发者配置调整。由于填充模式类别特别多，因此下面以一个例子来说明：
 */

-(void)drawRectByUIKitWithContext2:(CGContextRef)context{
    CGRect rect= CGRectMake(0, 130.0, 320.0, 50.0);
    CGRect rect1= CGRectMake(0, 390.0, 320.0, 50.0);
    
    
    CGRect rect2=CGRectMake(20, 50.0, 10.0, 250.0);
    CGRect rect3=CGRectMake(40.0, 50.0, 10.0, 250.0);
    CGRect rect4=CGRectMake(60.0, 50.0, 10.0, 250.0);
    CGRect rect5=CGRectMake(80.0, 50.0, 10.0, 250.0);
    CGRect rect6=CGRectMake(100.0, 50.0, 10.0, 250.0);
    CGRect rect7=CGRectMake(120.0, 50.0, 10.0, 250.0);
    CGRect rect8=CGRectMake(140.0, 50.0, 10.0, 250.0);
    CGRect rect9=CGRectMake(160.0, 50.0, 10.0, 250.0);
    CGRect rect10=CGRectMake(180.0, 50.0, 10.0, 250.0);
    CGRect rect11=CGRectMake(200.0, 50.0, 10.0, 250.0);
    CGRect rect12=CGRectMake(220.0, 50.0, 10.0, 250.0);
    CGRect rect13=CGRectMake(240.0, 50.0, 10.0, 250.0);
    CGRect rect14=CGRectMake(260.0, 50.0, 10.0, 250.0);
    CGRect rect15=CGRectMake(280.0, 50.0, 10.0, 250.0);
    
    CGRect rect16=CGRectMake(30.0, 310.0, 10.0, 250.0);
    CGRect rect17=CGRectMake(50.0, 310.0, 10.0, 250.0);
    CGRect rect18=CGRectMake(70.0, 310.0, 10.0, 250.0);
    CGRect rect19=CGRectMake(90.0, 310.0, 10.0, 250.0);
    CGRect rect20=CGRectMake(110.0, 310.0, 10.0, 250.0);
    CGRect rect21=CGRectMake(130.0, 310.0, 10.0, 250.0);
    CGRect rect22=CGRectMake(150.0, 310.0, 10.0, 250.0);
    CGRect rect23=CGRectMake(170.0, 310.0, 10.0, 250.0);
    CGRect rect24=CGRectMake(190.0, 310.0, 10.0, 250.0);
    CGRect rect25=CGRectMake(210.0, 310.0, 10.0, 250.0);
    CGRect rect26=CGRectMake(230.0, 310.0, 10.0, 250.0);
    CGRect rect27=CGRectMake(250.0, 310.0, 10.0, 250.0);
    CGRect rect28=CGRectMake(270.0, 310.0, 10.0, 250.0);
    CGRect rect29=CGRectMake(290.0, 310.0, 10.0, 250.0);
    
    
    [[UIColor yellowColor]set];
    UIRectFill(rect);
    
    [[UIColor greenColor]setFill];
    UIRectFill(rect1);
    
    [[UIColor redColor]setFill];
    UIRectFillUsingBlendMode(rect2, kCGBlendModeClear);
    UIRectFillUsingBlendMode(rect3, kCGBlendModeColor);
    UIRectFillUsingBlendMode(rect4, kCGBlendModeColorBurn);
    UIRectFillUsingBlendMode(rect5, kCGBlendModeColorDodge);
    UIRectFillUsingBlendMode(rect6, kCGBlendModeCopy);
    UIRectFillUsingBlendMode(rect7, kCGBlendModeDarken);
    UIRectFillUsingBlendMode(rect8, kCGBlendModeDestinationAtop);
    UIRectFillUsingBlendMode(rect9, kCGBlendModeDestinationIn);
    UIRectFillUsingBlendMode(rect10, kCGBlendModeDestinationOut);
    UIRectFillUsingBlendMode(rect11, kCGBlendModeDestinationOver);
    UIRectFillUsingBlendMode(rect12, kCGBlendModeDifference);
    UIRectFillUsingBlendMode(rect13, kCGBlendModeExclusion);
    UIRectFillUsingBlendMode(rect14, kCGBlendModeHardLight);
    UIRectFillUsingBlendMode(rect15, kCGBlendModeHue);
    UIRectFillUsingBlendMode(rect16, kCGBlendModeLighten);
    
    UIRectFillUsingBlendMode(rect17, kCGBlendModeLuminosity);
    UIRectFillUsingBlendMode(rect18, kCGBlendModeMultiply);
    UIRectFillUsingBlendMode(rect19, kCGBlendModeNormal);
    UIRectFillUsingBlendMode(rect20, kCGBlendModeOverlay);
    UIRectFillUsingBlendMode(rect21, kCGBlendModePlusDarker);
    UIRectFillUsingBlendMode(rect22, kCGBlendModePlusLighter);
    UIRectFillUsingBlendMode(rect23, kCGBlendModeSaturation);
    UIRectFillUsingBlendMode(rect24, kCGBlendModeScreen);
    UIRectFillUsingBlendMode(rect25, kCGBlendModeSoftLight);
    UIRectFillUsingBlendMode(rect26, kCGBlendModeSourceAtop);
    UIRectFillUsingBlendMode(rect27, kCGBlendModeSourceIn);
    UIRectFillUsingBlendMode(rect28, kCGBlendModeSourceOut);
    UIRectFillUsingBlendMode(rect29, kCGBlendModeXOR);
}


/*
 在UIView的drawRect:中绘制的图形会在控件显示的时候调用（而且显示时会重绘所有图形），有时候我们希望绘制内容的显示是实时的，此时我们就需要调用绘图方法重新绘制，但是在iOS开发中不允许开发者直接调用drawRect:方法，刷新绘制内容需要调用setNeedsDisplay方法。下面以一个调整字体大小的界面演示一下视图的刷新。
 */

@end
