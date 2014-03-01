//
//  ZViewController.m
//  AFS3ClientExample
//
//  Created by Jai Govindani on 2/28/14.
//  Copyright (c) 2014 Zodio. All rights reserved.
//

#import "ZViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "AFS3Client.h"

#define ACCESS_KEY  @"ACCESS_KEY"
#define SECRET_KEY  @"SECRET_KEY"
#define BUCKET      @"BUCKET"
#define UPLOAD_PATH @"/afs3client-test-uploads/"

@interface ZViewController ()

@end

@implementation ZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseSomethingToUpload:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSString *itemPath;
    
    if (CFStringCompare((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        //Movie
        itemPath= [(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL] path];
//        NSURL *videoURL = (NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(itemPath)) {
            UISaveVideoAtPathToSavedPhotosAlbum(itemPath, nil, nil, nil);
        }
        
        //Need to work out how to get video NSData and upload it - no time right now, irrelevant
        
    } else {
        //Handle photo upload
        itemPath = [(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL] path];
        NSData *imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.8);
        [self uploadData:imageData];
    }

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadData:(NSData*)data {
    AFS3Client *s3client = [[AFS3Client alloc] initWithAccessKey:ACCESS_KEY
                                                 secretAccessKey:SECRET_KEY
                                                          bucket:BUCKET];
    
    NSTimeInterval microTime = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%f.jpg", microTime];
    NSString *destinationFilePath = [NSString stringWithFormat:@"%@%@", UPLOAD_PATH, fileName];
    
    [self.uploadActivityIndicator startAnimating];
    
    [s3client putObjectForData:data
                    withBucket:BUCKET
                           key:destinationFilePath
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           
                           [self.uploadActivityIndicator stopAnimating];
                           
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           
                           [self.uploadActivityIndicator stopAnimating];
                           
                       } progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                           CGFloat progress = (totalBytesWritten * 1.0f) / (totalBytesExpectedToWrite * 1.0f);
                           [self.uploadProgressView setProgress:progress animated:YES];
                       }];
}

@end
