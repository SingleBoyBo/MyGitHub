//
//  TabbarController.m
//  封装
//
//  Created by bever on 16/2/19.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "TabbarController.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建新的标签视图
    newTabbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 49)];
    
    newTabbar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all"]];
    [self.tabBar addSubview:newTabbar];
    
    
}

//在视图将要出现的时候去除原生的tabbarbutton
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //去除原生tabbarbutton
    [self removeTabbarButton];


}

- (void)removeTabbarButton {
    
    
    //1.先遍历出tabbar中所有的view
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [view removeFromSuperview];
        }
    }
}

//复写viewControllers这个属性设置按钮个图片
- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    [super setViewControllers:viewControllers];
    
    //创建按钮
    [self createTabbarBtn];


}

- (void)createTabbarBtn {

    //1.首先获取控制器的个数
   int itemCount = (int)self.viewControllers.count;
    
    //创建选中图片
    selectedImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_menu_bottom_bg"]];
    
    selectedImg.frame = CGRectMake(0, 0, kScreenW/itemCount, 49);
    [newTabbar addSubview:selectedImg];
    
    //2.循环创建按钮
    int i = 0;
    for (UIViewController *viewController in self.viewControllers) {//根据控制器的个数确定按钮的个数
        TabbarItem *item = [[TabbarItem alloc] initWithFrame:CGRectMake(kScreenW/itemCount*i, 0, kScreenW/itemCount, 49) tabbarItem:viewController.tabBarItem];
        [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        
        item.tag = 100 + i;
        [newTabbar addSubview:item];
        
        i ++;
    }

}

- (void)itemAction:(TabbarItem *)item {
    self.selectedIndex = item.tag - 100;
    int itemCount = (int)self.viewControllers.count;
    int i = (int)item.tag - 100;
    [UIView animateWithDuration:0.3 animations:^{
        //根据选中的按钮 改变选中按钮图片的frame
        selectedImg.frame = CGRectMake((kScreenW/itemCount)*i, 0, kScreenW/itemCount, 49);
    
    }];
    



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

#pragma mark - 实现新类的方法
@implementation TabbarItem

- (id)initWithFrame:(CGRect)frame tabbarItem:(UITabBarItem *)item {

    self = [super initWithFrame:frame];
    
    if (self) {
        //封装标签视图中所有自定义的按钮
        
        //创建一个图片，然后将这个图片给标签项的image属性
        //frame是初始化TabbarItem的时候传进来的
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 20)/2, 8, 20, 20)];
        //防止图片拉伸
        imgView.contentMode = UIViewContentModeCenter;//位于中间
        //item也是初始化TabbarItem的时候传进来的，item中包含了title和image属性
        imgView.image = item.image;
        
        //创建标题
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bounds.size.height + imgView.frame.origin.y, frame.size.width, 20)];
        
        //让label中的内容赋给item中的文本
        label.text = item.title;
        label.font = [UIFont systemFontOfSize:12];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor orangeColor];
        
        if (item.title) {
            imgView.image = item.image;
            label.text = item.title;
            [self addSubview:imgView];
            [self addSubview:label];
        }else {
            imgView.frame = CGRectMake((frame.size.width - 40)/2, 5, 40,40);
            [self addSubview:imgView];
            
        }
        
    }

    return self;
}


@end














