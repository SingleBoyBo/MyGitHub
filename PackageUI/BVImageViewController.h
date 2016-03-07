//
//  BVImageViewController.h
//  BVImageView
//
//  Created by sunfeng on 16/3/5.
//  Copyright © 2016年 SunFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVImageView.h"

@interface BVImageViewController : UIViewController<UIScrollViewDelegate>
{
    NSInteger _index;
}

@property (nonatomic,retain)NSArray *data;

@property (nonatomic,strong)BVImageItem *currentItem;

@property (nonnull,strong)BVImageView *imageView;

@end
