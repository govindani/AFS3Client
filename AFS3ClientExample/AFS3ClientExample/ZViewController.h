//
//  ZViewController.h
//  AFS3ClientExample
//
//  Created by Jai Govindani on 2/28/14.
//  Copyright (c) 2014 Zodio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *uploadProgressView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *uploadActivityIndicator;

- (IBAction)chooseSomethingToUpload:(id)sender;

@end
