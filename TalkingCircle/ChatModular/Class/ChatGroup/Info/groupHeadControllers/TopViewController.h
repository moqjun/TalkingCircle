//
//  TopViewController.h
//  BM
//
//  Created by hackxhj on 15/9/7.
//  Copyright (c) 2015年 hackxhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "PersonModel.h"
@protocol TopViewControllerDelagate <NSObject>

-(void)addBtnClick:(NSArray*) addArray;
-(void)subBtnClick:(NSArray*) delArray;

@end
@interface TopViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,copy) NSMutableArray * arrayTemp;
@property(nonatomic,strong)id<TopViewControllerDelagate>delagate;


-(void)delOneTximg:(PersonModel*)person;
-(void)addOneTximg:(PersonModel*)person;

@property(nonatomic) BOOL   isGroupMember;

@end
