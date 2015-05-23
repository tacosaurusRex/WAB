//
//  MomentEnvelopeView.m
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import "MomentEnvelopeView.h"

@implementation MomentEnvelopeView

@synthesize tow, tom, lgw, lwm, zfw, zfm, bew, bem, fuelWeight, fuelGal, fuelMoment, frontSeatWeight, frontSeatMoment, rearSeatWeight, rearSeatMoment, bag1Weight, bag1Moment, bag2Weight, bag2Moment, taxiFuelGal, taxiFuelWeight, taxiFuelMoment;

float utilityEnvelope[] = {52.25, 1500.0, 68.0, 1950.0, 70.92855, 2000.0, 81.1, 2000.0, 60.75, 1500.0};
float normalEnvelope[] = {52.25, 1500.0, 68.0, 1950.0, 88.5, 2300.0, 109.0, 2300.0, 70.5, 1500.0};

- (void) drawEnvelopeWithContext:(CGContextRef)ctx
{
    [self getData];
    
    NSLog(@"I'm in MomentEnvelopeView");
    NSLog(@"Take-off Weight is %.1f", tow);
    NSLog(@"Take-off Moment is %.1f", tom);
    NSLog(@"Zero Fuel Weight is %.1f", zfw);
    NSLog(@"Zero Fuel Moment is %.1f", zfm);
    NSLog(@"Basic Empty Weight is %.1f", bew);
    NSLog(@"Basic Empty Moment is %.1f", bem);
    NSLog(@"Fuel Weight is %f", fuelWeight);
    CGFloat screenX = self.frame.size.width;
    CGFloat screenY = self.frame.size.height;
    float graphXScale = mXAxisMax-mXAxisMin;
    float graphYScale = mYAxisMax-mYAxisMin;
    float graphWidth = screenX - mRightSpace - mLeftSpace;
    float graphHeight = screenY - mTopSpace - mBottomSpace;

    //Flip y coordinates
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    //Draw Utility Category Envelope
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor blueColor] CGColor]);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, ((utilityEnvelope[0] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((utilityEnvelope[1]-mYAxisMin)/graphYScale)*graphHeight);
    for (int i = 2 ; i < sizeof(utilityEnvelope)/4 ; i+=2 )
    {
        CGContextAddLineToPoint(ctx, ((utilityEnvelope[i] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((utilityEnvelope[i+1]-mYAxisMin)/graphYScale)*graphHeight);
    }
    CGContextAddLineToPoint(ctx, ((utilityEnvelope[0] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((utilityEnvelope[1]-mYAxisMin)/graphYScale)*graphHeight);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);

    //Draw Normal Category Envelope
    CGContextSetStrokeColorWithColor(ctx, [[UIColor greenColor] CGColor]);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, ((normalEnvelope[0] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((normalEnvelope[1]-mYAxisMin)/graphYScale)*graphHeight);
    for (int i = 2 ; i < sizeof(normalEnvelope)/4 ; i+=2 )
    {
        CGContextAddLineToPoint(ctx, ((normalEnvelope[i] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((normalEnvelope[i+1]-mYAxisMin)/graphYScale)*graphHeight);
    }
    CGContextAddLineToPoint(ctx, ((normalEnvelope[0] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((normalEnvelope[1]-mYAxisMin)/graphYScale)*graphHeight);    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Draw Weight Line
    CGContextSetStrokeColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, ((tom/mMomentScale - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((tow-mYAxisMin)/graphYScale)*graphHeight);
    CGContextAddLineToPoint(ctx, ((zfm/mMomentScale - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((zfw-mYAxisMin)/graphYScale)*graphHeight);
    CGContextAddLineToPoint(ctx, ((bem/mMomentScale - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((bew-mYAxisMin)/graphYScale)*graphHeight);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Draw Dots
    /*
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1] CGColor]);
    for (int i = 0; i < 2 ; i++)
    {
        float x = kOffsetX + i * kStepX;
        float y = mGraphHeight - GraphHeight * data[i];
        CGRect rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, 2 * kCircleRadius, 2 * kCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    */
}

- (void) drawString: (NSString*) s
           withFont: (UIFont*) font
             inRect: (CGRect) contextRect {
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: [UIColor whiteColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGSize size = [s sizeWithAttributes:attributes];
    
    CGRect textRect = CGRectMake(contextRect.origin.x + floorf((contextRect.size.width - size.width) / 2),
                                 contextRect.origin.y + floorf((contextRect.size.height - size.height) / 2),
                                 size.width,
                                 size.height);
    
    [s drawInRect:textRect withAttributes:attributes];
}

- (void)drawRect:(CGRect)rect
{
    CGFloat screenX = self.frame.size.width;
    CGFloat screenY = self.frame.size.height;
    float graphXScale = mXAxisMax-mXAxisMin;
    float graphYScale = mYAxisMax-mYAxisMin;
    float howManyVertical = graphXScale/mXGridMajor+1;
    float howManyHorizontal = graphYScale/mYGridMajor+1;
    float graphWidth = screenX - mRightSpace - mLeftSpace;
    float graphHeight = screenY - mTopSpace - mBottomSpace;
    float xGridSpacing = graphWidth / (howManyVertical-1);
    float yGridSpacing = graphHeight / (howManyHorizontal-1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.2);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    
    CGFloat dash[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, dash, 2);
    
    // Here the lines go
    for (int i = 0 ; i < howManyVertical ; i++ )
    {
        CGContextMoveToPoint(context, mLeftSpace + i * xGridSpacing, mTopSpace);
        CGContextAddLineToPoint(context, mLeftSpace + i * xGridSpacing, graphHeight + mTopSpace);
    }

    for (int i = 0 ; i < howManyHorizontal ; i++ )
    {
        CGContextMoveToPoint(context, mLeftSpace, mTopSpace + i * yGridSpacing);
        CGContextAddLineToPoint(context, graphWidth + mLeftSpace, mTopSpace + i * yGridSpacing);
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, NULL, 0); // Remove the dash
    
    [self drawEnvelopeWithContext:context];
}

- (void)getData {
    
    UserInput *data = [UserInput sharedInput];
    
    fuelWeight = data.fuelWeight;
    fuelMoment = data.fuelMoment;
    frontSeatWeight = data.frontSeatWeight;
    frontSeatMoment = data.frontSeatMoment;
    rearSeatWeight = data.rearSeatWeight;
    rearSeatMoment = data.rearSeatMoment;
    bag1Weight = data.bag1Weight;
    bag1Moment = data.bag1Moment;
    bag2Weight = data.bag2Weight;
    bag2Moment = data.bag2Moment;
    taxiFuelWeight = data.taxiFuelWeight;
    taxiFuelMoment = data.taxiFuelMoment;
    
    tow = data.totalWeight;
    tom = data.totalMoment;
    zfw = data.totalWeight - data.fuelWeight + data.taxiFuelWeight;
    zfm = data.totalMoment - data.fuelMoment + data.taxiFuelMoment;
    bew = emptyWeight;
    bem = emptyWeightMoment;
}

@end
