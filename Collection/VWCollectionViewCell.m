//
//  VWCollectionViewCell.m
//  Collection
//
//  Created by Vic Wan on 2021/2/21.
//

#import "VWCollectionViewCell.h"

@interface VWCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation VWCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imageView];
    self.backgroundColor = UIColor.greenColor;
    return self;
}

- (void)setImg:(UIImage *)img {
    _img = img;
    [self.imageView setImage:img];
}

@end
