//
//  ButtonsView.m
//  练习界面
//
//  Created by bever on 16/2/23.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "ButtonsView.h"

@implementation ButtonsView {

    UIImageView *_changeImageView;


}
- (void)setTitle:(NSArray *)title {//数组的个数就是按钮的个数，数组中的元素就是按钮的标题
    
    
    _title = title;
    
    //创建按钮 (循环)
    for (int i = 0; i< _title.count; i++) {
        //创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.frame.size.width/_title.count*i, 0, self.frame.size.width/_title.count, self.frame.size.height);
        
        //设置按钮的标题，根据数组下标
        [btn setTitle:_title[i] forState:UIControlStateNormal];
        
        //根据状态设置按钮上字体的颜色，
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //设置字体大小
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        //判断创建的第一个按钮是否是选中状态
        if (i == 0) {
            btn.selected = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        
    }
    
}

- (void)btnAction:(UIButton *)btn {
    
    //判断选中的view是否是button
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            //如果是，就让此时的按钮的选中状态是NO
            UIButton *button = (UIButton *)view;
            button.selected = NO;//先让所有按钮的选中状态设置为NO
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            
        }
        
        //设置当前选中按钮的状态
        btn.selected = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        
    }
    
    //修改选中状态下图片的坐标（跟随按钮的位置移动）
    [UIView animateWithDuration:0.5 animations:^{
    
        _changeImageView.frame = CGRectMake(btn.frame.origin.x, self.frame.size.height - 2, btn.frame.size.width, 2);
    }];




}

    
//复写选中状态下的移动图片
- (void)setChangeImg:(NSString *)changeImg {
    _changeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width/_title.count, 2)];
    
    _changeImageView.image = [UIImage imageNamed:changeImg];
    
    [self addSubview:_changeImageView];

}




@end
