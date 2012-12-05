
#import "ISColorWheel.h"

typedef struct
{
    unsigned char r;
    unsigned char g;
    unsigned char b;
    
} PixelRGB;

float ISColorWheel_PointDistance (CGPoint p1, CGPoint p2)
{
    return sqrtf((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}


PixelRGB ISColorWheel_HSBToRGB (float h, float s, float v)
{
    h *= 6.0f;
    int i = floorf(h);
    float f = h - (float)i;
    float p = v *  (1.0f - s);
    float q = v * (1.0f - s * f);
    float t = v * (1.0f - s * (1.0f - f));
    
    float r;
    float g;
    float b;
    
    switch (i)
    {
        case 0:
            r = v;
            g = t;
            b = p;
            break;
        case 1:
            r = q;
            g = v;
            b = p;
            break;
        case 2:
            r = p;
            g = v;
            b = t;
            break;
        case 3:
            r = p;
            g = q;
            b = v;
            break;
        case 4:
            r = t;
            g = p;
            b = v;
            break;
        default:        // case 5:
            r = v;
            g = p;
            b = q;
            break;
    }
    
    PixelRGB pixel;
    pixel.r = r * 255.0f;
    pixel.g = g * 255.0f;
    pixel.b = b * 255.0f;
    
    return pixel;
}

@interface ISColorWheel ()

- (PixelRGB)colorAtPoint:(CGPoint)point;

- (CGPoint)viewToImageSpace:(CGPoint)point;


@end



@implementation ISColorWheel
@synthesize radius = _radius;
@synthesize cursorRadius = _cursorRadius;
@synthesize brightness = _brightness;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _brightness = 1.0;
        _cursorRadius = 8;
        _touchPoint = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
        self.backgroundColor = [UIColor clearColor];
        
        _continuous = false;
    }
    return self;
}


- (PixelRGB)colorAtPoint:(CGPoint)point
{
    CGPoint center = CGPointMake(_radius, _radius);
    
    float angle = atan2(point.x - center.x, point.y - center.y) + M_PI;
    float dist = ISColorWheel_PointDistance(point, CGPointMake(center.x, center.y));
    
    float hue = angle / (M_PI * 2.0f);
    
    hue = MIN(hue, 1.0f - .0000001f);
    hue = MAX(hue, 0.0f);
    
    float sat = dist / (_radius);
    
    sat = MIN(sat, 1.0f);
    sat = MAX(sat, 0.0f);
    
    return ISColorWheel_HSBToRGB(hue, sat, _brightness);
}

- (CGPoint)viewToImageSpace:(CGPoint)point
{    
    int width = self.bounds.size.width;
    int height = self.bounds.size.height;
    
    point.y = height - point.y;
        
    CGPoint min = CGPointMake(width / 2 - _radius, height / 2 - _radius);
    
    point.x = point.x - min.x;
    point.y = point.y - min.y;
    
    return point;
}

- (void)updateImage
{
    int width = _radius * 2.0;
    int height = _radius * 2.0;
    
    int dataLength = sizeof(PixelRGB) * width * height;
    PixelRGB* data = malloc(dataLength);
    
    for (int y = 0; y < height; y++)
    {
        for (int x = 0; x < width; x++)
        {
            data[x + y * width] = [self colorAtPoint:CGPointMake(x, y)];
        }
    }
    
    CGBitmapInfo bitInfo = kCGBitmapByteOrderDefault;
    
	CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
	CGImageRef iref = CGImageCreate (width,
                                     height,
                                     8,
                                     24,
                                     width * 3,
                                     colorspace,
                                     bitInfo,
                                     ref,
                                     NULL,
                                     true,
                                     kCGRenderingIntentDefault
                                     );
    
    _radialImage = [[UIImage imageWithCGImage:iref] retain];
    
    CGImageRelease(iref);
    
    [self setNeedsDisplay];
}

- (UIColor*)currentColor
{
    PixelRGB pixel = [self colorAtPoint:[self viewToImageSpace:_touchPoint]];    
    return [UIColor colorWithRed:pixel.r / 255.0f green:pixel.g / 255.0f blue:pixel.b / 255.0f alpha:1.0];
}

- (void)setCurrentColor:(UIColor*)color
{
    
}

- (void)drawRect:(CGRect)rect
{
    int width = self.bounds.size.width;
    int height = self.bounds.size.height;
    
    CGPoint center = CGPointMake(width / 2.0, height / 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState (ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(center.x - _radius, center.y - _radius, _radius * 2.0, _radius * 2.0));
    CGContextClip(ctx);
    
    CGContextDrawImage(ctx, CGRectMake(center.x - _radius, center.y - _radius, _radius * 2.0, _radius * 2.0), [_radialImage CGImage]);
    
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor blackColor] CGColor]);
    CGContextAddEllipseInRect(ctx, CGRectMake(_touchPoint.x - _cursorRadius, _touchPoint.y - _cursorRadius, _cursorRadius * 2.0, _cursorRadius * 2.0));
    CGContextAddEllipseInRect(ctx, CGRectMake(center.x - _radius, center.y - _radius, _radius * 2.0, _radius * 2.0));
    CGContextStrokePath(ctx);

    CGContextRestoreGState (ctx);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _radius = (MIN(self.frame.size.width, self.frame.size.height) / 2.0) - 1.0;
    [self updateImage];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setTouchPoint:[[touches anyObject] locationInView:self]];
    [self setNeedsDisplay];
    
    if (_continuous)
    {
        [_delegate colorWheelDidChangeColor:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setTouchPoint:[[touches anyObject] locationInView:self]];
    [self setNeedsDisplay];
    
    if (_continuous)
    {
        [_delegate colorWheelDidChangeColor:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_delegate colorWheelDidChangeColor:self];
}

- (void)setTouchPoint:(CGPoint)point
{
    int width = self.bounds.size.width;
    int height = self.bounds.size.height;
    
    CGPoint center = CGPointMake(width / 2.0, height / 2.0);
    
    // Check if the touch is outside the wheel
    if (ISColorWheel_PointDistance(center, point) < _radius)
    {
        _touchPoint = point;
    }
    else
    {
        // If so we need to create a drection vector and calculate the constrained point
        CGPoint vec = CGPointMake(point.x - center.x, point.y - center.y);
        
        float extents = sqrtf((vec.x * vec.x) + (vec.y * vec.y));
        
        vec.x /= extents;
        vec.y /= extents;
        
        _touchPoint = CGPointMake(center.x + vec.x * _radius, center.y + vec.y * _radius);
    }
}

@end
