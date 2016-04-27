//
//  AppDelegate.m
//  C-Color
//
//  Created by Nelson Nahum on 4/26/16.
//  Copyright © 2016 Gabriel Nahum. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//return 0-255
-(int)getRed:(long) color{
    return (int) (((color & 0xff000000) >>24));
}
//return 0-255
-(int)getGreen:(long)color{
    return (int) (((color & 0x00ff0000) >>16));
}
//return 0-255
-(int)getBlue:(long)color{
    return (int) (((color & 0x0000ff00))>>8);
}

-(NSString *)getColor:(unsigned long) midColor{
    int rRed = [self getRed:midColor]/32;
    // NSLog(@"Red:", [self getRed:midColor], @"\nrRed:", rRed);
    int rBlue = [self getBlue:midColor]/ 32;
    int rGreen = [self getGreen:midColor]/ 32;
    int reducedColor = ((rRed*64) + (rGreen * 8) + (rBlue));
    if (([self getRed:midColor] + [self getBlue:midColor] + [self getGreen:midColor]) == 765)
        return @"White";
    
    for (int i = 0; i<513; i++) {
        if(i == reducedColor)
            return colors[i];
    }
    return @"Not recognizable";
}
-(NSString *)getNameOfColor:(UIColor *)color{
    NSInteger reducedColor = color.hash;
    reducedColor = reducedColor/32;
    if(reducedColor == 765){
        return @"White";
    }
    for(int i =0; i<512; i++){
        if(i == reducedColor){
            return colors[i];
        }
    }
    return @"Not Recognizable";
}


NSString *colors[512] = { @"Black", @"Black", @"Black", @"Blue", @"Blue", @"Blue", @"Blue",@"Blue",
    @"Black",@"Black",@"Black", @"Blue",@"Blue",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Blue",@"Blue",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",
    
    @"Black",@"Black",@"Black",@"Black",@"Purple",@"Purple",@"Blue",@"Blue",
    @"Black",@"Black",@"Black",@"Black",@"Blue",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Blue",@"Blue",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",
    
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Green",@"Green",@"Gray",@"Gray",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Green",@"Green",@"Green",@"Gray",@"Gray",@"Purple",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",
    
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Gray",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Green",@"Green",@"Gray",@"Gray",@"Gray",@"Gray",@"Purple",@"Purple",
    @"Green",@"Green",@"Green",@"Gray",@"Gray",@"Gray",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Gray",@"Gray",@"Blue",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",
    
    @"Red",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Gray",@"Gray",@"Purple",@"Purple",@"Purple",
    @"Green",@"Green",@"Green",@"Gray",@"Gray",@"Gray",@"Gray",@"Purple",
    @"Green",@"Green",@"Green",@"Green",@"Gray",@"Gray",@"Gray",@"Gray",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Gray",@"Gray",@"Purple",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",
    
    @"Red",@"Red",@"Red",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Gray",@"Gray",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Brown",@"Gray",@"Gray",@"Purple",@"Purple",
    @"Green",@"Green",@"Green",@"Gray",@"Gray",@"Gray",@"Gray",@"Purple",
    @"Green",@"Green",@"Green",@"Green",@"Gray",@"Gray",@"Gray",@"Gray",
    @"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Green",@"Blue",
    
    @"Red",@"Red",@"Red",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Brown",@"Purple",@"Purple",@"Purple",@"Purple",
    @"Brown",@"Brown",@"Brown",@"Brown",@"Gray",@"Purple",@"Purple",@"Purple",
    @"Yellow",@"Yellow",@"Yellow",@"Yellow",@"Gray",@"Gray",@"Gray",@"Purple",
    @"Yellow",@"Yellow",@"Yellow",@"Yellow",@"Gray",@"Gray",@"Gray",@"Gray",
    @"Green",@"Green",@"Green",@"Green",@"Gray",@"Gray",@"Gray",@"Gray",
    
    @"Red",@"Red",@"Red",@"Red",@"Pink",@"Pink",@"Pink",@"Pink",
    @"Red",@"Red",@"Red",@"Red",@"Pink",@"Pink",@"Pink",@"Pink",
    @"Orange",@"Orange",@"Red",@"Red",@"Pink",@"Pink",@"Pink",@"Pink",
    @"Orange",@"Orange",@"Orange",@"Red",@"Pink",@"Pink",@"Pink",@"Pink",
    @"Orange",@"Orange",@"Orange",@"Orange",@"Pink",@"Pink",@"Pink",@"Pink",
    @"Orange",@"Orange",@"Orange",@"Orange",@"Orange",@"Pink",@"Pink",@"Pink",
    @"Orange",@"Orange",@"Orange",@"Orange",@"Orange",@"Gray",@"Pink",@"Pink",
    @"Yellow",@"Yellow",@"Yellow",@"Yellow",@"Yellow",@"Gray",@"Gray",@"Gray"};


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
