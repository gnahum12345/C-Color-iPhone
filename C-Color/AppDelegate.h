//
//  AppDelegate.h
//  C-Color
//
//  Created by Nelson Nahum on 4/26/16.
//  Copyright © 2016 Gabriel Nahum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSData *img;
-(int)getRed:(long) color;
-(int)getBlue:(long)color;
-(int)getGreen:(long)color;
-(NSString *)getColor:(long) midColor;
-(NSString *)getNameOfColor:(UIColor*)color;


@end

