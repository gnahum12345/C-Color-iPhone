//
//  ViewController.m
//  C-Color
//
//  Created by Nelson Nahum on 4/26/16.
//  Copyright © 2016 Gabriel Nahum. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "CoreController.h"
@interface ViewController ()

@end

@implementation ViewController



bool flashlightOn = false;
AVCaptureSession *session;
AVCaptureStillImageOutput *stillImageOutput;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    }
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [self.view layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = self.frameForCapture.frame;
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:0];
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithInt:640], AVVideoWidthKey,
                                    [NSNumber numberWithInt:480], AVVideoHeightKey,
                                    [NSNumber numberWithFloat:0.5],AVVideoQualityKey,
                                    AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:stillImageOutput];
    
    [session startRunning];
}

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)openFile:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        /*
                 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
                 NSString *documentsDirectory = [paths objectAtIndex:0];
                 NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
                UIImage *image = _imageView.image; // imageView is my image from camera
                NSData *imageData = UIImagePNGRepresentation(image);
                 [imageData writeToFile:savedImagePath atomically:NO];
        */
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.image = (UIImage*) [info objectForKey:UIImagePickerControllerOriginalImage];
//        
//         CoreController *vc2 = [[CoreController alloc] init]; // create object of VC2
//         // [self.navigationController pushViewController:vc2 animated:YES];
//         [self.navigationController presentViewController:vc2 animated:YES completion:nil];
        
       
    }];

}

- (void)imagePickerController:(UIImagePickerController *) Picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    appDelegate.img = UIImageJPEGRepresentation(image,1.0);
    [Picker dismissModalViewControllerAnimated:YES];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CoreController *cc = [sb instantiateViewControllerWithIdentifier:@"CoreController"];
    [self presentViewController:cc animated:YES completion:nil];

}

- (IBAction)flashlight:(id)sender {
    
    //    printf("Im in flashlight ");
    //    // check if flashlight available
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    //    printf("going into if");
    if (captureDeviceClass != nil) {
        //        printf("in first if");
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasFlash]){
            //            printf("in second if");
            [device lockForConfiguration:nil];
            if (flashlightOn) {
                //                printf("im in third if");
                [device setFlashMode:AVCaptureFlashModeOff];
                [device setTorchMode:AVCaptureTorchModeOff];
                flashlightOn = false;
                //                printf("Flashlight is off");
                //                //torchIsOn = no; //define as a variable/property if you need to know status
            } else {
                [device setFlashMode:AVCaptureFlashModeOn];
                [device setTorchMode:AVCaptureTorchModeOn];
                flashlightOn = true;
                //                //torchIsOn = yes;
                //                printf("Flashlight is on");
            }
            [device unlockForConfiguration];
        }
    }
     
    
    
    NSString *message = @"";
    if(flashlightOn){
        //        printf("Flashlight is on\n");
        message = @"Flashlight on";
    }else{
        //        printf("Flashlight is off\n");
        message = @"Flashlight off";
    }
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    
    float duration = .75; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });

}

- (IBAction)test1:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImage *img =  [UIImage imageNamed:@"Blue_Green"];
    appDelegate.img = UIImageJPEGRepresentation(img,1.0);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CoreController *cc = [sb instantiateViewControllerWithIdentifier:@"CoreController"];
    [self presentViewController:cc animated:YES completion:nil];
//    
}

- (IBAction)test2:(id)sender {

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImage *img =  [UIImage imageNamed:@"E"];
    appDelegate.img = UIImageJPEGRepresentation(img,1.0);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CoreController *cc = [sb instantiateViewControllerWithIdentifier:@"CoreController"];
    [self presentViewController:cc animated:YES completion:nil];
}

- (IBAction)test3:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImage *img =  [UIImage imageNamed:@"Green-Red"];
    appDelegate.img = UIImageJPEGRepresentation(img,1.0);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CoreController *cc = [sb instantiateViewControllerWithIdentifier:@"CoreController"];
    [self presentViewController:cc animated:YES completion:nil];
}

- (IBAction)test4:(id)sender {
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImage *img =  [UIImage imageNamed:@"Red-Green"];
    appDelegate.img = UIImageJPEGRepresentation(img,1.0);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CoreController *cc = [sb instantiateViewControllerWithIdentifier:@"CoreController"];
    [self presentViewController:cc animated:YES completion:nil];
}

- (IBAction)test5:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIImage *img =  [UIImage imageNamed:@"test 5"];
    appDelegate.img = UIImageJPEGRepresentation(img,1.0);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CoreController *cc = [sb instantiateViewControllerWithIdentifier:@"CoreController"];
    [self presentViewController:cc animated:YES completion:nil];
    
}


- (IBAction)color:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIImage *imageForView = [UIImage imageWithData:appDelegate.img];
    
    CGImageRef imageRef = [imageForView CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    
    NSUInteger height = CGImageGetHeight(imageRef);
    //  unsigned char RGB = getRGBfromImage;
    //TODO
    NSMutableString *labelForColor = [NSMutableString stringWithString: @"Color: "];
    
    [labelForColor appendString:[appDelegate getColor:width*height]];
    
    [_colorLabel setText:labelForColor];
}

- (IBAction)captureImage:(id)sender {

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //   appDelegate.img = UIImageJPEGRepresentation(_imageView.image, 1.0);
    
    //  printf("You clicked Captured Imaged");
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            appDelegate.img = imageData;
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CoreController *cc = [sb instantiateViewControllerWithIdentifier:@"CoreController"];
            [self presentViewController:cc animated:YES completion:nil];
            
        }
    }];

    
}
@end
