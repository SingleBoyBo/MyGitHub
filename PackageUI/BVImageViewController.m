//
//  BVImageViewController.m
//  BVImageView
//
//  Created by sunfeng on 16/3/5.
//  Copyright © 2016年 SunFeng. All rights reserved.
//

#import "BVImageViewController.h"
#import "UIImageView+WebCache.h"

@interface BVImageViewController (){
    UIScrollView *_scrollView;
}

@end

@implementation BVImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect newFrame = [self.currentItem.superview convertRect:self.currentItem.frame toView:self.view];
    
    self.currentItem.frame = newFrame;
    [self.view addSubview:self.currentItem];
    
    //创建滑动视图
    [self loadScrollView];
}

- (void)loadScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * _data.count, self.view.frame.size.height);
    
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    _scrollView.hidden = YES;
    
    for (int i = 0; i < _data.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.bounds.size.width, self.view.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        NSString *str = _data[i];
        [imageView setImageWithURL:[NSURL URLWithString:str]];
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        
        [imageView addGestureRecognizer:tap];
        
        [_scrollView addSubview:imageView];
        
    }
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self startZoomIn];
    
}

- (void)startZoomIn{

    [UIView animateWithDuration:0.4 animations:^{
        
        //更改self.currentItem.frame
        self.currentItem.frame = self.view.bounds;
        
    } completion:^(BOOL finished) {
        
        //恢复item到原来的位置上
        self.currentItem.frame = self.currentItem.originFrame;
        [self.imageView addSubview:self.currentItem];
        
        _scrollView.hidden = NO;
        [_scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width * self.currentItem.index, 0, self.view.frame.size.width, self.view.frame.size.height) animated:NO];
    }];
}

- (void)dismiss{
    
    BVImageItem *item = [self.imageView.items objectAtIndex:_index];
    
    //把item放到最上层
    [item.superview bringSubviewToFront:item];
    
    CGPoint point = [self.view convertPoint:CGPointZero toView:self.imageView];
    
    item.frame = CGRectMake(point.x, point.y, self.view.frame.size.width, self.view.frame.size.height);
    
    
    //控制器dismiss
    [self dismissViewControllerAnimated:NO completion:^{
        
        [UIView animateWithDuration:0.35 animations:^{
            item.frame = item.originFrame;
        }];
        
        
    }];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _index = scrollView.contentOffset.x/scrollView.frame.size.width;
}


@end
