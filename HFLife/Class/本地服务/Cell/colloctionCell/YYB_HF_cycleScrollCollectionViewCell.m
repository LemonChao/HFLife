//
//  YYB_HF_cycleScrollCollectionViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_cycleScrollCollectionViewCell.h"
#import "SDCycleScrollView.h"
@interface YYB_HF_cycleScrollCollectionViewCell()<SDCycleScrollViewDelegate>
@property (nonatomic ,strong) SDCycleScrollView *cycleScroll;

@end
@implementation YYB_HF_cycleScrollCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    [self.contentView addSubview:self.cycleScroll];
    [self.cycleScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(0);
        make.right.mas_equalTo(self.contentView).mas_offset(0);
        make.top.mas_equalTo(self.contentView).mas_offset(0);
        make.height.mas_equalTo(ScreenScale(92));
    }];
}

//广告位
-(SDCycleScrollView *)cycleScroll{
    if (_cycleScroll == nil) {
        _cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScroll.isCustom = YES;
        _cycleScroll.distance = HeightRatio(47);
        _cycleScroll.delegate = self;
        _cycleScroll.tag = -4000;
        _cycleScroll.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScroll.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        
        //        _cycleScroll.backgroundColor = [UIColor brownColor];
    }
    return _cycleScroll;
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
        NSLog(@"图片----- %ld", index);
    if (self.picItemAtIndex) {
        self.picItemAtIndex(index);
    }
    //    bannerModel *model = self.bannerListModel[index];
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedBannerImageIndex:Url:)]) {
    //        [self.delegate selectedBannerImageIndex:index Url:model.advert_url];
    //    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    //    NSLog(@"----- %ld", index);
}

- (void)setCycleImageArr:(NSArray *)imageUrlArr {
    _cycleScroll.imageURLStringsGroup = imageUrlArr;
//    _cycleScroll.imageURLStringsGroup = @[@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=1&spn=0&di=177320&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=3300305952%2C1328708913&os=188573792%2C343995474&simid=4174703319%2C828922280&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fpic37.nipic.com%2F20140113%2F8800276_184927469000_2.png&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bgtrtv_z%26e3Bv54AzdH3Ffi5oAzdH3F9AzdH3F898AzdH3Flm808c0_z%26e3Bip4s&gsm=0&islist=&querylist=",@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=2&spn=0&di=111043033200&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=935292084%2C2640874667&os=929535083%2C139004715&simid=3383873348%2C359765392&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fwww.pptok.com%2Fwp-content%2Fuploads%2F2012%2F08%2Fxunguang-4.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Brrp5h_z%26e3Bv54AzdH3F2sw6j-us5o-rrp-kwvh2657g1-rtvp76j_z%26e3Bip4s&gsm=0&islist=&querylist="];
}

@end
