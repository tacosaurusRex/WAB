//
//  MomentEnvelopeView.m
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import "MomentEnvelopeView.h"

@implementation MomentEnvelopeView

@synthesize tow, tom, lgw, lwm, zfw, zfm, bew, bem, fuelWeight, fuelGal, fuelMoment, frontSeatWeight, frontSeatMoment, rearSeatWeight, rearSeatMoment, bag1Weight, bag1Moment, bag2Weight, bag2Moment, taxiFuelWeight, taxiFuelMoment, flightFuelWeight, flightFuelMoment;

float utilityEnvelope[] = {52.25, 1500.0, 68.0, 1950.0, 70.92855, 2000.0, 81.1, 2000.0, 60.75, 1500.0};
float normalEnvelope[] = {52.25, 1500.0, 68.0, 1950.0, 88.5, 2300.0, 109.0, 2300.0, 70.5, 1500.0};


- (void)drawAxisLabels
{
    CGFloat screenX = self.frame.size.width;
    CGFloat screenY = self.frame.size.height;
    float graphWidth = screenX - mRightSpace - mLeftSpace;
    float graphHeight = screenY - mTopSpace - mBottomSpace;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    UIFont *axisLabelFont = [UIFont fontWithName:@"Verdana" size:axisLabelFontSize];
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    // Format the string
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: axisLabelFont,
                                  NSForegroundColorAttributeName: [UIColor whiteColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    // X-AXIS LABEL
    // Create text
    NSString *xAxisLabel = @"Loaded Aircraft Moment/1000 (Pound-Inches)";
    CGSize xSize = [xAxisLabel sizeWithAttributes:attributes];
    CGRect xRect = CGRectMake ((graphWidth/2+mLeftSpace)-(xSize.width/2), screenY-16, xSize.width, xSize.height);
    [xAxisLabel drawInRect:xRect withAttributes:attributes];
    
    //Y-AXIS LABEL
    // Rotate the context 90 degrees (convert to radians)
    CGAffineTransform transform1 = CGAffineTransformMakeRotation(-90.0 * M_PI/180.0);
    CGContextConcatCTM(ctx, transform1);
    
    // Create text
    NSString *yAxisLabel = @"Loaded Aircraft Weight (Pounds)";
    CGSize ySize = [yAxisLabel sizeWithAttributes:attributes];
    CGRect yRect = CGRectMake (0, 0, ySize.width, ySize.height);
    
    // Move the context back into the view
    CGContextTranslateCTM(ctx, -((graphHeight+20)/2+ySize.width/2), 7);
    //Draw the string
    [yAxisLabel drawInRect:yRect withAttributes:attributes];
    
    CGContextRestoreGState(ctx);
}

- (void) drawEnvelopeWithContext:(CGContextRef)ctx
{
    [self getData];
    
    CGFloat screenX = self.frame.size.width;
    CGFloat screenY = self.frame.size.height;
    float graphXScale = mXAxisMax-mXAxisMin;
    float graphYScale = mYAxisMax-mYAxisMin;
    float graphWidth = screenX - mRightSpace - mLeftSpace;
    float graphHeight = screenY - mTopSpace - mBottomSpace;
    float line[] = {tom, tow, lwm, lgw, zfm, zfw, bem, bew};
    
    //Draw Text
    UIFont *axisLabelFont = [UIFont fontWithName:@"Verdana" size:axisLabelFontSize];
    
    //Draw Y-Axis Labels
    int yLabelCount = graphYScale / mYGridMajor;
    for ( int i = 0 ; i <= yLabelCount ; i++ ) {
        CGRect text = CGRectMake(mLeftSpace-5, ((i*(graphHeight/yLabelCount))+mTopSpace), 0, 0);
        
        [self drawRJString:[NSString stringWithFormat:@"%.0d",(mYAxisMax-i*mYGridMajor)] withFont:axisLabelFont inRect:text];
    }
    
    //Draw X-Axis Labels
    int xLabelCount = graphXScale / mXGridMajor;
    for ( int i = 1 ; i < xLabelCount ; i++ ) {
        CGRect text = CGRectMake( i*(graphWidth/xLabelCount)+mLeftSpace, screenY-(mBottomSpace-12), 0, 0);
        [self drawCJString:[NSString stringWithFormat:@"%.0d",(mXAxisMin+i*mXGridMajor)] withFont:axisLabelFont inRect:text];
        //       ^^^Is it really necessary to have separate drawString methods for left justified and center justified labels??
    }
    
    //Flip y coordinates
    CGContextSaveGState(ctx);
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
    CGContextMoveToPoint(ctx, ((line[0]/mMomentScale - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((line[1]-mYAxisMin)/graphYScale)*graphHeight);
    for (int i = 2 ; i < sizeof(line)/4 ; i+=2 )
    {
        CGContextAddLineToPoint(ctx, ((line[i]/mMomentScale - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace, mBottomSpace+((line[i+1]-mYAxisMin)/graphYScale)*graphHeight);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Draw Dots
    CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
    CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
    for (int i = 0; i <= sizeof(line)/4 ; i++)
    {
        float x = ((line[i]/mMomentScale - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace;
        float y = (mBottomSpace+((line[i+1]-mYAxisMin)/graphYScale)* graphHeight);

        CGRect rect = CGRectMake(x - mCircleRadius, y - mCircleRadius, 2 * mCircleRadius, 2 * mCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRestoreGState(ctx);
    
    CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
    NSArray *point = [NSArray arrayWithObjects: @"TOW", @"LGW", @"ZFW", @"BEW", nil];
    for (int i = 0; i < 4 ; i++)
    {
        float x = ((line[0+(i*2)]/mMomentScale - mXAxisMin)/graphXScale) * graphWidth + mLeftSpace;
        float y = (mTopSpace + (graphHeight - ((line[1+(i*2)]-mYAxisMin)/graphYScale) * graphHeight));
        CGRect text = CGRectMake( x+15, y+7, 0, 0);
        [self drawCJString:[NSString stringWithString:point[i]] withFont:axisLabelFont inRect:text];
    }
    
}

- (void) drawRJString: (NSString*) s
           withFont: (UIFont*) font
             inRect: (CGRect) contextRect {
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentRight;
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: [UIColor whiteColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGSize size = [s sizeWithAttributes:attributes];
    
    CGRect textRect = CGRectMake(contextRect.origin.x + floorf((contextRect.size.width - size.width) / 1),
                                 contextRect.origin.y + floorf((contextRect.size.height - size.height) / 2),
                                 size.width,
                                 size.height);

    [s drawInRect:textRect withAttributes:attributes];
}

- (void) drawCJString: (NSString*) s
             withFont: (UIFont*) font
               inRect: (CGRect) contextRect {
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphXStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphXStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphXStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: [UIColor whiteColor],
                                  NSParagraphStyleAttributeName: paragraphXStyle };
    
    CGSize size = [s sizeWithAttributes:attributes];
    
    CGRect textRect = CGRectMake(contextRect.origin.x + floorf((contextRect.size.width - size.width) / 2),
                                 contextRect.origin.y + floorf((contextRect.size.height - size.height) / 1),
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
    [self drawAxisLabels];
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
    flightFuelWeight = data.flightFuelWeight;
    flightFuelMoment = data.flightFuelMoment;
    taxiFuelWeight = data.taxiFuelWeight;
    taxiFuelMoment = data.taxiFuelMoment;
    
    tow = data.totalWeight;
    tom = data.totalMoment;
    lgw = tow - flightFuelWeight;
    lwm = tom - flightFuelMoment;
    zfw = tow - data.fuelWeight;
    zfm = tom - data.fuelMoment;
    bew = emptyWeight;
    bem = emptyWeightMoment;
}

@end
