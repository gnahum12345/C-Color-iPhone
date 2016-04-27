//
//  ViewController.h
//  C-Color
//
//  Created by Nelson Nahum on 4/26/16.
//  Copyright © 2016 Gabriel Nahum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)openFile:(id)sender;
- (IBAction)flashlight:(id)sender;
- (IBAction)test1:(id)sender;
- (IBAction)test2:(id)sender;
- (IBAction)test3:(id)sender;
- (IBAction)test4:(id)sender;
- (IBAction)test5:(id)sender;
- (IBAction)color:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *frameForCapture;

- (IBAction)captureImage:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;

- (NSUInteger) supportedInterfaceOrientations;

@end

