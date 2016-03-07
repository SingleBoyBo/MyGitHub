//
//  TabbarController.h
//  封装
//
//  Created by bever on 16/2/19.
//  Copyright © 2016年 bever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarController : UITabBarController {

    UIView *newTabbar;//自定义一个新的标签视图
    
    UIImageView *selectedImg;//添加点击图片
    
}


@end

//重新创建一个类
@interface TabbarItem : UIControl

- (id)initWithFrame:(CGRect)frame tabbarItem:(UITabBarItem *)item;
@end