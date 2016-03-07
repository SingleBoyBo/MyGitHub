//
//  BVImageView.h
//  BVImageView
//
//  Created by sunfeng on 16/3/5.
//  Copyright © 2016年 SunFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BVImageView : UIView

@property (nonatomic,retain)NSArray *data;

@property (nonatomic,retain)NSMutableArray *items;

@end

//子类化ImageView

@interface BVImageItem : UIImageView

//记录下标
@property (nonatomic,assign) NSInteger index;

//记录在imageView上的坐标
@property (nonatomic,assign)CGRect originFrame;

//自定义初始化方法
- (id)initWithFrame:(CGRect)frame withTarget:(id)target action:(SEL)action;

@end