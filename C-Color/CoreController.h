//
//  CoreController.h
//  C-Color
//
//  Created by Gaby Nahum on 2/20/16.
//  Copyright © 2016 Gaby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreController : UIViewController <UIGestureRecognizerDelegate>

- (NSUInteger) supportedInterfaceOrientations;
- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *coreImageView;
- (IBAction)brown:(id)sender;
- (IBAction)blue:(id)sender;
- (IBAction)red:(id)sender;
- (IBAction)pink:(id)sender;
- (IBAction)orange:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)purple:(id)sender;
- (IBAction)gray:(id)sender;
- (IBAction)toggleSwitchAction:(id)sender;
- (IBAction)yellow:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *toggleSwitchButton;
@property (strong, nonatomic) IBOutlet UISwitch *brownOutlet;
@property (strong, nonatomic) IBOutlet UISwitch *yellowOutlet;
@property (strong, nonatomic) IBOutlet UISwitch *greenOutlet;
@property (strong, nonatomic) IBOutlet UISwitch *blueOutlet;
@property (strong, nonatomic) IBOutlet UISwitch *redOutlet;
@property (strong, nonatomic) IBOutlet UISwitch *pinkOutlet;
@property (strong, nonatomic) IBOutlet UISwitch *purpleOutlet;
@property (strong, nonatomic) IBOutlet UISwitch *orangeOutlet;
@property (strong, nonatomic) IBOutlet UISwitch *grayOutlet;

@end
