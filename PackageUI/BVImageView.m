//
//  BVImageView.m
//  BVImageView
//
//  Created by sunfeng on 16/3/5.
//  Copyright © 2016年 SunFeng. All rights reserved.
//

#import "BVImageView.h"
#import "UIImageView+WebCache.h"
#import "BVImageViewController.h"
#import "UIView+UIViewController.h"


#define kItemSpace 10

@implementation BVImageView

- (void)setData:(NSArray *)data{
    
    _data = data;
    _items = [[NSMutableArray alloc] init];

    
    for (int i = 0; i < _data.count; i++) {
        
        BVImageItem *item = [[BVImageItem alloc] initWithFrame:[self frameAtIndex:i] withTarget:self action:@selector(itemTap:)];
        
        [item setImageWithURL:[NSURL URLWithString:_data[i]]];
        item.originFrame = item.frame;
        item.index = i;
        [_items addObject:item];
        [self addSubview:item];
    }
    
    
}

- (void)itemTap:(UIGestureRecognizer *)tap{
    
    BVImageItem *item = (BVImageItem *)tap.view;
    
    BVImageViewController *vc = [[BVImageViewController alloc] init];
    
    vc.data = self.data;
    vc.currentItem = item;
    vc.imageView = self;
    [self.viewController presentViewController:vc animated:NO completion:nil];
    
}

//根据下标，计算frame
- (CGRect)frameAtIndex:(NSInteger )index{

    CGFloat itemWidth = (self.frame.size.width - kItemSpace*4)/3;
    
    CGFloat x = (index%3) * itemWidth + (index%3 + 1)*kItemSpace;
    CGFloat y = (index/3) * itemWidth + (index/3 + 1)*kItemSpace;

    return CGRectMake(x, y, itemWidth, itemWidth);
}


@end

@implementation BVImageItem

- (id)initWithFrame:(CGRect)frame withTarget:(id)target action:(SEL)action{
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.userInteractionEnabled = YES;
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        tap.numberOfTapsRequired = YES;
        
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
    
}


@end
