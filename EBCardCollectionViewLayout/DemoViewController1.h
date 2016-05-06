//
//  DemoViewController1.h
//  EBCardCollectionViewLayout
//
//  Created by GaoWanli on 16/5/6.
//  Copyright © 2016年 Ezequiel A Becerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EBCardCollectionViewLayout.h"

@interface DemoViewController1 : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>{
    NSMutableArray *_people;
    __weak IBOutlet UICollectionView *_collectionView;
}

@end