//
//  SDWebImageRootViewController.h
//  Sample
//  照片标签页面
//  Created by Kirby Turner on 3/18/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTThumbsViewController.h"
@class FlickrDataSource;

@interface SFlickrRootViewController : SKTThumbsViewController {
    FlickrDataSource *images_;
}
@property(nonatomic,retain)UINavigationController *navigationController;
-(void)initImage;
@end
