//
//  LGFooterCollectionReusableView.m
//  LGPhotoBrowser
//
//  Created by ligang on 15/10/27.
//  Copyright (c) 2015年 L&G. All rights reserved.

#import "LGPhotoPickerFooterCollectionReusableView.h"

@interface LGPhotoPickerFooterCollectionReusableView ()

@property (nonatomic, weak) UILabel *footerLabel;

@end

@implementation LGPhotoPickerFooterCollectionReusableView

- (UILabel *)footerLabel {
    if (!_footerLabel) {
        UILabel *footerLabel = [[UILabel alloc] init];
        footerLabel.frame = self.bounds;
        footerLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:footerLabel];
        self.footerLabel = footerLabel;
    }
    return _footerLabel;
}

- (void)setCount:(NSInteger)count {
    _count = count;
    
    if (count > 0) {
        self.footerLabel.text = [NSString stringWithFormat:@"There are %ld images", (long)count];
    }
}

@end
