//
//  CoreController.m
//  C-Color
//
//  Created by Gaby Nahum on 2/20/16.
//  Copyright © 2016 Gaby. All rights reserved.
//

#import "CoreController.h"
#import "AppDelegate.h"

@implementation CoreController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 //   printf("Viewdidload");
  
    _coreImageView.image = [[UIImage alloc] initWithData:appDelegate.img];
    
   
    isBlack = true;

    if(isBlack){
        [_toggleSwitchButton setTitle: @"White" forState:UIControlStateNormal];
    }else{
        [_toggleSwitchButton setTitle: @"Black" forState:UIControlStateNormal];
    }
    UIImage *img = [UIImage imageWithData:appDelegate.img];
    CGImageRef imageRef = [img CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    
    NSUInteger height = CGImageGetHeight(imageRef);
    

    NSMutableString *labelForColor = [NSMutableString stringWithString: @"Color: "];
    
    [labelForColor appendString:[appDelegate getColor:width*height]];
    
    [_label setText:labelForColor];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickEventOnImage:)];
    [tapGestureRecognizer setNumberOfTouchesRequired:1];
    [tapGestureRecognizer setDelegate:self];
    self.coreImageView.userInteractionEnabled = YES; // default is no for UIImageView
    [self.coreImageView addGestureRecognizer:tapGestureRecognizer];
    //
}
//- (void)tappedImage:(UIGestureRecognizer *)gestureRecognizer {
//    //UIImageView *myImage = (UIImageView *)gestureRecognizer.view;
//    // do stuff;
//    printf("it works");
//}

-(void) ClickEventOnImage:(UITapGestureRecognizer *)tapRecognizer
{
   CGPoint point = [tapRecognizer locationInView:_coreImageView];
   // double width = point.x;
   // double height = point.y;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   //_coreImageView.image = [[UIImage alloc] initWithData:appDelegate.img];
    unsigned char *RGB = [self getRGBAFromImage:_coreImageView.image];
    CGImageRef imageRef = [_coreImageView.image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    //NSUInteger width = 375;
    // NSUInteger height = 394;
//    
    NSMutableString *labelForColor = [NSMutableString stringWithString: @"Color: "];
//
    float x = point.x*width/375;
    float y = point.y*height/394;
    int byteIndex = (width*4 * y) + x * 4;
//   
    int iColor = ((RGB[byteIndex]<<24) & 0xff000000) | ((RGB[byteIndex+1] << 16) & 0x00ff0000) | ((RGB[byteIndex+2] <<8) & 0x0000ff00) | (RGB[byteIndex+3]&0x000000ff);

    [labelForColor appendString:[appDelegate getColor:iColor]];
    
    [_label setText:labelForColor];
    free(RGB);
    
//    printf("\ntouched %f %f %d %x %x %x %x %x %s", point.x, point.y, byteIndex, (RGB[byteIndex]&0xff000000), (RGB[byteIndex+1]&0xffff0000), (RGB[byteIndex+2]&0xffffff00), RGB[byteIndex+3], iColor, [[appDelegate getColor:iColor] UTF8String]);
//
//    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(_coreImageView.image.CGImage));
//    const UInt8* data = CFDataGetBytePtr(pixelData);
//    int pixelInfo = ((_coreImageView.image.size.width  * point.y) + point.x ) * 4; // The image is png
//    
//    UInt8 red = (data[pixelInfo]);         // If you need this info, enable it
//    UInt8 green = (data[(pixelInfo + 1)]); // If you need this info, enable it
//    UInt8 blue = (data[pixelInfo + 2]);    // If you need this info, enable it
//    UInt8 alpha = data[pixelInfo + 3];     // I need only this info for my maze game
//    CFRelease(pixelData);
//    
//    UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info
    
}

-(unsigned char*)getRGBAFromImage:(UIImage*)image {

    
//    NSMutableArray *resultColor = [NSMutableArray array];
    
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);

    NSUInteger height = CGImageGetHeight(imageRef);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    
    NSUInteger bytesPerPixel = 4;
    
    NSUInteger bytesPerRow = bytesPerPixel * width;
    
    NSUInteger bitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    
    
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    
//    int byteIndex = (bytesPerRow * yp) + xp * bytesPerPixel;
    
//    CGFloat red   = (rawData[byteIndex]     * 1.0) /255.0;
    
//    CGFloat green = (rawData[byteIndex + 1] * 1.0)/255.0 ;
    
//    CGFloat blue  = (rawData[byteIndex + 2] * 1.0)/255.0 ;
    
//    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) /255.0;
    
//    byteIndex += 4;
    
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
//    [resultColor addObject:color];
    
    
//    free(rawData);
    
    return rawData;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)brown:(id)sender {
    [self changeImage];
}

- (IBAction)blue:(id)sender {
    [self changeImage];
}

- (IBAction)red:(id)sender {
    [self changeImage];
}

- (IBAction)pink:(id)sender {
    [self changeImage];
}

- (IBAction)orange:(id)sender {
    [self changeImage];
}

- (IBAction)green:(id)sender {
    [self changeImage];
}

- (IBAction)purple:(id)sender {
    [self changeImage];
}

- (IBAction)gray:(id)sender {
    [self changeImage];
}

- (IBAction)yellow:(id)sender {
    [self changeImage];
}

bool isBlack = true;
- (IBAction)toggleSwitchAction:(id)sender {
    if(isBlack){
        [_toggleSwitchButton setTitle: @"Black" forState:UIControlStateNormal];
        isBlack = false;
    }else{
        [_toggleSwitchButton setTitle: @"White" forState:UIControlStateNormal];
        isBlack = true;
    }
    [self changeImage];
    
}


-(NSString *)boxesChecked{
    NSMutableString* s = [NSMutableString stringWithString: @""];
    
    if([_blueOutlet isOn]){
        [s appendString: @"Blue "];
    }
    if([_redOutlet isOn]){
        [s appendString:@"Red "];
    }
    if([_brownOutlet isOn]){
        [s appendString:@"Brown "];
    }
    if ([_yellowOutlet isOn]){
        [s appendString:@"Yellow "];
    }
    if([_orangeOutlet isOn]){
        [s appendString:@"Orange"];
    }
    if([_grayOutlet isOn]){
        [s appendString:@"Gray"];
    }
    if([_purpleOutlet isOn]){
        [s appendString:@"Purple"];
    }
    if([_pinkOutlet isOn]){
        [s appendString:@"Pink"];
    }
    if([_greenOutlet isOn]){
        [s appendString:@"Green"];
    }
    
    return s;
}

-(void)changeImage{
    if(isBlack){
        [_toggleSwitchButton setTitle: @"White" forState:UIControlStateNormal];
    }else{
        [_toggleSwitchButton setTitle: @"Black" forState:UIControlStateNormal];
    }
    NSString *colors2Change = [self boxesChecked];
 //   printf("%s",[colors2Change UTF8String]);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
       UIImage *originalImage = [[UIImage alloc] initWithData:appDelegate.img];
    // _coreImageView.image = [_coreImageView.image scaleToSize:CGSizeMake(300.0f, 300.0f)];
 
    ///////////////////////////////
    // resizing image
 
    CGRect scaledImageRect = CGRectZero;
    CGSize newSize = CGSizeMake(375.0f, 394.0f);
    CGImageRef oImageRef = [originalImage CGImage];
    
    NSUInteger oWidth = CGImageGetWidth(oImageRef);
    
    NSUInteger oHeight = CGImageGetHeight(oImageRef);
    
    CGFloat aspectWidth = newSize.width / oWidth;
    CGFloat aspectHeight = newSize.height / oHeight;
    CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
    
    scaledImageRect.size.width = oWidth * aspectRatio;
    scaledImageRect.size.height = oHeight * aspectRatio;
    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0f;
    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0f;
    
    UIGraphicsBeginImageContextWithOptions( newSize, NO, 0 );
    [originalImage drawInRect:scaledImageRect];
    _coreImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  //////////////////////////////////////////
    
    
    
    unsigned char *RGB = [self getRGBAFromImage:_coreImageView.image];
    CGImageRef imageRef = [_coreImageView.image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    
    NSUInteger height = CGImageGetHeight(imageRef);
   
    unsigned char *nRGB = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    if(nRGB==nil)
    {
     //   printf("dddd");
    }
        
    for(int i =0; i<(height*width*4); i+=4){
        unsigned long pixel = RGB[i] & 0xff;
        pixel = (pixel << 24)&0xff000000;
        pixel = pixel | ((RGB[i+1] << 16 )&0x00ff0000);
        pixel = pixel | ((RGB[i+2] << 8)&0x0000ff00);
        pixel = pixel | ((RGB[i+3])&0x000000ff);
        
        
        if([colors2Change rangeOfString:[self getPixelColor:pixel]].location == NSNotFound){
            nRGB[i] = RGB[i];
            nRGB[i+1] = RGB[i+1];
            nRGB[i+2] = RGB[i+2];
            nRGB[i+3] = RGB[i+3];
        }else{
            if(isBlack){
                nRGB[i] = 0;
                nRGB[i+1] = 0;
                nRGB[i+2] = 0;
                nRGB[i+3] = 0;
            }else{
                nRGB[i] = 255;
                nRGB[i+1] = 255;
                nRGB[i+2] = 255;
                nRGB[i+3] = 0;
            }
        }
    
    }
    
    CGDataProviderRef dataProviderRef;
    CGColorSpaceRef colorSpaceRef;
    CGImageRef imageRef1;
    
    GLubyte *rawImageDataBuffer = nRGB;
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;

    dataProviderRef = CGDataProviderCreateWithData(NULL, rawImageDataBuffer, width*height*4, nil);
    colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    imageRef1 = CGImageCreate(width, height, 8, 8 * 4, width * 4, colorSpaceRef, bitmapInfo, dataProviderRef, NULL, NO, renderingIntent);
    _coreImageView.image = [UIImage imageWithCGImage:imageRef1];


  //  free(nRGB);
    free(RGB);
    
}

-(NSString *)getPixelColor:(long)color{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *returnString = [appDelegate getColor:color];
    return returnString;
}


- (IBAction)save:(id)sender {
    UIImage *imageToBeSaved = _coreImageView.image;
    UIImageWriteToSavedPhotosAlbum(imageToBeSaved, nil, nil, nil);
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"Your image was saved"
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    float duration = .25; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
}


- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}
@end