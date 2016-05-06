//
//  DemoViewController1.m
//  EBCardCollectionViewLayout
//
//  Created by GaoWanli on 16/5/6.
//  Copyright © 2016年 Ezequiel A Becerra. All rights reserved.
//

#import "DemoViewController1.h"
#import "DemoCollectionViewCell.h"

const CGFloat kMaxScale = 1.2;

@interface DemoViewController1 ()

@end

@implementation DemoViewController1

#pragma mark - Public

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *peopleData = @[@{@"name" : @"Dexter Pinkman", @"twitter" : @"loboscator", @"avatarFilename" : @"loboscator.jpg"},
                            @{@"name" : @"Asgardian Squirrel", @"twitter" : @"pepper__potts", @"avatarFilename" : @"pepperpotts.jpg"},
                            @{@"name" : @"HeronswayDreamWeaver", @"twitter" : @"nieblah", @"avatarFilename" : @"nieblah.jpg"},
                            @{@"name" : @"F", @"twitter" : @"vestidofloreado", @"avatarFilename" : @"f.jpg"},
                            @{@"name" : @"Morán", @"twitter" : @"fernandomoran", @"avatarFilename" : @"fernandomoran.jpg"},
                            @{@"name" : @"SweetN'Sour Carolain", @"twitter" : @"aCarolain", @"avatarFilename" : @"acarolain.jpg"},
                            @{@"name" : @"Joaquin Casarini", @"twitter" : @"jcasarini", @"avatarFilename" : @"jcasarini.jpg"},
                            @{@"name" : @"Gastón Oliva", @"twitter" : @"gastonoliva", @"avatarFilename" : @"gastonoliva.jpg"},
                            @{@"name" : @"Anita Baggiano", @"twitter" : @"anitabagg", @"avatarFilename" : @"anitabagg.jpg"},
                            @{@"name" : @"Ezequiel", @"twitter" : @"betzerra", @"avatarFilename" : @"betzerra.jpg"},
                            @{@"name" : @"Dexter Pinkman", @"twitter" : @"loboscator", @"avatarFilename" : @"loboscator.jpg"},
                            @{@"name" : @"Asgardian Squirrel", @"twitter" : @"pepper__potts", @"avatarFilename" : @"pepperpotts.jpg"},
                            @{@"name" : @"HeronswayDreamWeaver", @"twitter" : @"nieblah", @"avatarFilename" : @"nieblah.jpg"},
                            @{@"name" : @"F", @"twitter" : @"vestidofloreado", @"avatarFilename" : @"f.jpg"},
                            @{@"name" : @"Morán", @"twitter" : @"fernandomoran", @"avatarFilename" : @"fernandomoran.jpg"},
                            @{@"name" : @"SweetN'Sour Carolain", @"twitter" : @"aCarolain", @"avatarFilename" : @"acarolain.jpg"},
                            @{@"name" : @"Joaquin Casarini", @"twitter" : @"jcasarini", @"avatarFilename" : @"jcasarini.jpg"},
                            @{@"name" : @"Gastón Oliva", @"twitter" : @"gastonoliva", @"avatarFilename" : @"gastonoliva.jpg"},
                            @{@"name" : @"Anita Baggiano", @"twitter" : @"anitabagg", @"avatarFilename" : @"anitabagg.jpg"},
                            @{@"name" : @"Ezequiel", @"twitter" : @"betzerra", @"avatarFilename" : @"betzerra.jpg"}
                            ];
    _people = [[NSMutableArray alloc] init];
    
    for (NSDictionary *personDict in peopleData) {
        Person *aPerson = [[Person alloc] initWithDictionary:personDict];
        [_people addObject:aPerson];
    }
    
    UIOffset anOffset = UIOffsetZero;
    self.title = @"Horizontal Scrolling";
    anOffset = UIOffsetMake(40, 40);
    [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setOffset:anOffset];
    [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setLayoutType:EBCardCollectionLayoutHorizontal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _collectionView.contentOffset = CGPointMake(0, 0);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_people count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoCollectionViewCell *retVal = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell"
                                                                               forIndexPath:indexPath];
    retVal.person = _people[indexPath.row];
    return retVal;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, kMaxScale);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *visibleCells = _collectionView.visibleCells;
    NSInteger count = visibleCells.count;
    for (NSInteger index = 0; index < count; index++) {
        [self scaleCell:visibleCells[index]];
    }
}

- (void)scaleCell:(UICollectionViewCell *)cell {
    CGFloat scalingAreaWidth = CGRectGetWidth(cell.bounds) * 0.5;
    CGFloat maximumScalingAreaWidth = (CGRectGetWidth(cell.bounds) * 0.5 - scalingAreaWidth) * 0.5;
    
    CGFloat distanceFromMainPosition = ABS(CGRectGetMidX(cell.frame) - _collectionView.contentOffset.x - (CGRectGetWidth(cell.bounds) * 0.5));
    
    CGFloat preferredScale = 0.0;
    CGFloat minScale = 1;
    
    if (distanceFromMainPosition < maximumScalingAreaWidth) {
        preferredScale = kMaxScale;
    } else if (distanceFromMainPosition < (maximumScalingAreaWidth + scalingAreaWidth)) {
        CGFloat multiplier = ABS((distanceFromMainPosition - maximumScalingAreaWidth) / scalingAreaWidth);
        preferredScale = kMaxScale - multiplier * (kMaxScale - minScale);
    } else {
        preferredScale = minScale;
    }
    cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, preferredScale);
}

@end
