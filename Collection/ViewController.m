//
//  ViewController.m
//  Collection
//
//  Created by Vic Wan on 2021/2/21.
//

#import "ViewController.h"
#import "VWCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray *imgs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupCollectionView];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(100, 200);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = UIColor.redColor;
    [collectionView registerClass:[VWCollectionViewCell class] forCellWithReuseIdentifier:@"haha"];
    
    [self.view addSubview:collectionView];
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.imgs.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *arr = self.imgs[section];
    return arr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"haha" forIndexPath:indexPath];
        cell.img = self.imgs[indexPath.section][indexPath.item];
        NSLog(@"%@", cell.img);
    
    return cell;
}

- (NSArray *)imgs {
    if (!_imgs) {
        NSMutableArray *ret = [NSMutableArray array];
        NSMutableArray *tmp = [NSMutableArray array];
        for (int i = 0; i < 26; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
            [tmp addObject:img];
            if (tmp.count == 5) {
                [ret addObject:tmp.copy];
                [tmp removeAllObjects];
            }
        }
        _imgs = ret.copy;
    }
    return _imgs;
}


@end
