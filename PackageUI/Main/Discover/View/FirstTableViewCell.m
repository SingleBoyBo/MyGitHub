//
//  FirstTableViewCell.m
//  PackageUI
//
//  Created by bever on 16/2/24.
//  Copyright © 2016年 bever. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(HotModel *)model {
    
    _model = model;
    
    _titleLabel.text = model.t;
    
    //设置评分
    NSMutableAttributedString *rate = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.r]];
    //判断评分的长度
    if (rate.length == 3) {
        [rate addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(1, 2)];
        
        _ratingLabel.attributedText = rate;
    }else {
    
        if ([model.r floatValue] <= 0) {
            //重新给model中评分属性赋值
            model.r = 0;
        }
        _ratingLabel.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.1f",[model.r floatValue]]];
    
    }
    
    //评论内容
    if ([model.commonSpecial isEqualToString:@""]) {
        NSMutableAttributedString *common = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人在期待上映",model.wantedCount]];
        
        [common addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, [NSString stringWithFormat:@"%@",model.wantedCount].length)];
        
        _commonLabel.attributedText = common;
    }else {
    
        _commonLabel.text = model.commonSpecial;
    }

    //日期
    NSString *str = [NSString stringWithFormat:@"%@",model.rd];
    NSString *month = [str substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [str substringWithRange:NSMakeRange(6, 2)];
    NSString *text = [NSString stringWithFormat:@"%@月%@日上映",month,day];
    _dateLabel.text = text;
    
    //最近影院上映的场数
    _showLabel.text = [NSString stringWithFormat:@"今日%@家影院 %@场",model.NearestCinemaCount,model.NearestShowtimeCount];

    UIImage *image1 = [UIImage imageNamed:@"icon_hot_show_IMAX3D"];
    UIImage *image2 = [UIImage imageNamed:@"icon_hot_show_IMAX"];
    UIImage *image3 = [UIImage imageNamed:@"icon_hot_show_DMAX"];
    
    if ([model.is3D intValue] == 1) {
        _imgView1.image = image1;
    }else {
        _imgView1.image = image2;
    }

    if ([model.isIMAX intValue] == 1&&[model.is3D intValue] == 1) {
        _imgView2.image = image2;
    }else {
        _imgView2.image = image3;
    }
    
    if ([model.isDMAX intValue] == 1&&[model.is3D intValue] == 1&&[model.isIMAX intValue] == 1) {
        _imgView3.image = image3;
    }else {
        _imgView3.hidden = YES;
    }

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
