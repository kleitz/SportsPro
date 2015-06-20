//
//  NYSegmentLabel.m
//  NYSegmentLabel
//
//  Copyright (c) 2015 Peter Gammelgaard. All rights reserved.
//
//  https://github.com/nealyoung/NYSegmentedControl
//

#import "NYSegmentLabel.h"

@interface NYSegmentLabel ()
{
    BOOL _needRelease;
    
}

@end

@implementation NYSegmentLabel

- (void)setMaskFrame:(CGRect)maskFrame {
    _maskFrame = maskFrame;

    [self setNeedsDisplay];
}

- (void)setMaskCornerRadius:(CGFloat)maskCornerRadius {
    _maskCornerRadius = maskCornerRadius;

    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Draw text normally
    [super drawTextInRect:rect];

    if (self.alternativeTextColor) {
        CGImageRef mask = NULL;

        // Create a mask from the text
        mask = CGBitmapContextCreateImage(context);

        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, self.frame.size.height);
        CGContextScaleCTM(context, 1.0, (CGFloat) -1.0);

        // Clip the current context to our mask
        CGContextClipToMask(context, rect, mask);

        // Set fill color
        CGContextSetFillColorWithColor(context, [self.alternativeTextColor CGColor]);

        // Path from mask
        CGPathRef path = [self CreatePathForRoundedRect:self.maskFrame radius:self.maskCornerRadius];
        
        CGContextAddPath(context, path);
        
        // Fill the path
        CGContextFillPath(context);

        // Clean up
        CGContextRestoreGState(context);
        CGImageRelease(mask);


        
    }
}

- (CGPathRef)CreatePathForRoundedRect:(CGRect)rect radius:(CGFloat)radius {
    
    if (CGRectIsEmpty(rect)) {
        
        _needRelease = YES;
        CGMutablePathRef path = CGPathCreateMutable();
        
        return CFAutorelease(path);
    }
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    _needRelease = YES;
    return [path CGPath];
}

- (UIColor *)alternativeTextColor {
    if (!_alternativeTextColor) {
        _alternativeTextColor = self.textColor;
    }
    
    return _alternativeTextColor;
}

@end
