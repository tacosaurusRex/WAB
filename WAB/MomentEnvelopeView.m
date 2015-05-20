//
//  MomentEnvelopeView.m
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import "MomentEnvelopeView.h"

@implementation MomentEnvelopeView

@synthesize theNum;

float utilityEnvelope[] = {52.25, 1500.0, 68.0, 1950.0, 70.92855, 2000.0, 81.1, 2000.0, 60.75, 1500.0};
float normalEnvelope[] = {52.25, 1500.0, 68.0, 1950.0, 88.5, 2300.0, 109.0, 2300.0, 70.5, 1500.0};

- (void) drawEnvelopeWithContext:(CGContextRef)ctx
{
    //float fuelWeight = super.data.fuelWeight;
    NSLog(@"thenum is %ld", theNum);
    
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
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:0 green:1 blue:0 alpha:1] CGColor]);
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
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:0 green:0 blue:1 alpha:1] CGColor]);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, ((normalEnvelope[0] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((normalEnvelope[1]-mYAxisMin)/graphYScale)*graphHeight);
    for (int i = 2 ; i < sizeof(normalEnvelope)/4 ; i+=2 )
    {
        CGContextAddLineToPoint(ctx, ((normalEnvelope[i] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((normalEnvelope[i+1]-mYAxisMin)/graphYScale)*graphHeight);
    }
    CGContextAddLineToPoint(ctx, ((normalEnvelope[0] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((normalEnvelope[1]-mYAxisMin)/graphYScale)*graphHeight);    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //float fuelWeight = data.fuelWeight;
    //float fuelMoment = data.fuelMoment;
    //NSLog (@"fuelWeight is %f and fuelMoment is %f", fuelWeight, fuelMoment);
    //CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:0 green:0 blue:1 alpha:1] CGColor]);
    //CGContextBeginPath(ctx);
    //CGContextMoveToPoint(ctx, ((normalEnvelope[0] - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((normalEnvelope[1]-mYAxisMin)/graphYScale)*graphHeight);
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


@end
