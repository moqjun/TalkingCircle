//
//  TopViewController.m
//  BM
//
//  Created by hackxhj on 15/9/7.
//  Copyright (c) 2015年 hackxhj. All rights reserved.
//


#import "TopViewController.h"
#import  "CollectionViewCell.h"
 static NSString *kcellIdentifier = @"collectionCellID";
@interface TopViewController ()<CollectionViewCellDelagate>

@end


@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kcellIdentifier];
    self.collectionView.backgroundColor=[UIColor whiteColor];

    _dataArr=[NSMutableArray new];
    _arrayTemp=[NSMutableArray new];
}

//删除成员
-(void)delOneTximg:(PersonModel*)person
{
    _arrayTemp = _dataArr;
    NSArray * array = [NSArray arrayWithArray: _arrayTemp];
    for (PersonModel *pp in array) {
        if([pp.friendId isEqualToString:person.friendId])
        {
            [_arrayTemp removeObject:pp];
        }
    }
    
    _dataArr=[_arrayTemp mutableCopy];
    [self.collectionView reloadData];
}

//添加成员
-(void)addOneTximg:(PersonModel*)person
 {
   [_dataArr addObject:person];
   [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger count =self.isGroupMember? 1:2;
      return _dataArr.count+count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    cell.delagate=self;
    if(indexPath.row==_dataArr.count)
    {
       
        cell.nameLabel.text=@"";
        cell.imageView.image=[UIImage imageNamed:@"group-add"];
    }else if(indexPath.row==_dataArr.count+1)
    {
      cell.nameLabel.text=@"";
      cell.imageView.image=[UIImage imageNamed:@"group-reduce"];
    }else
    {
      
        PersonModel *pm=_dataArr[indexPath.row];
        cell.nameLabel.text=pm.userName;
        cell.imageView.image=pm.txicon;

    }
    cell.imageViewCornerRadius = 3;
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellviewbackground"]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 80);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//分别为上、左、下、右
}

#pragma  mark  cell delagate
-(void)clickImg:(UITapGestureRecognizer *)recognizer;
{
    id sender=recognizer.view;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:(CollectionViewCell *)[[sender superview] superview]];

    if(indexPath.row==_dataArr.count)  //添加
    {
        [self.delagate addBtnClick:nil];

    }else if(indexPath.row==_dataArr.count+1)
    {
        [self.delagate subBtnClick:nil];
    }
    
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
