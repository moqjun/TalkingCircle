//
//  MQTaoPayController.m
//  TalkingCircle
//
//  Created by iMac on 2017/5/4.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#import "MQTaoPayController.h"

#import "TCPaymentReceivedController.h"

#import "MQCollectionViewCell.h"
#import "UIButton+Extend.h"

@interface MQTaoPayController ()

@end



@implementation MQTaoPayController


        
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        //        flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+10);//头部大小
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 160, WIDTH_SCREEN, HEIGHT_SCREEN-160) collectionViewLayout:flowLayout];
        
        //定义每个UICollectionView 的大小
        CGFloat itemWidth =(WIDTH_SCREEN)/3;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 0;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上左下右
        
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[MQCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        //        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //背景颜色
        _collectionView.backgroundColor = [UIColor whiteColor];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    return _collectionView;
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:DEFAULT_MAIN_COLOR]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.title =@"淘支付";
    
    [self doCreateHeadView];
    
    
    [self.view addSubview:self.collectionView];
    
    
}

-(void) doCreateHeadView
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 150)];
    view.backgroundColor = [UIColor colorWithHexString:@"17151f"];
    
    //
    CGFloat yy = HEIGHT_NAVBAR+20;
    CGFloat width = 60;
    CGFloat height = 80;
    CGFloat xx =(WIDTH_SCREEN-60*3)/4;
    
    UIButton *payBtn =[self creatCustomButton:@"收付款" imageNamed:@"scan" rect:CGRectMake(xx, yy, width, height)];
    payBtn.tag = 0;
    [view addSubview:payBtn];
    
    UIButton *moneyBtn =[self creatCustomButton:@"零钱" imageNamed:@"change" rect:CGRectMake(xx*2+width, yy, width, height)];
    moneyBtn.tag = 1;
    [view addSubview:moneyBtn];
    
    UIButton *cardBtn =[self creatCustomButton:@"银行卡" imageNamed:@"card" rect:CGRectMake(xx*3+width*2, yy, width, height)];
    cardBtn.tag = 2;
    [view addSubview:cardBtn];
    
    
    [self.view addSubview:view];
}

-(UIButton *) creatCustomButton:(NSString *) title imageNamed:(NSString*) imageName
                           rect:(CGRect) rect
{
    UIButton *btn =[[TCUpDownButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
  
    [btn addTarget:self action:@selector(onClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

-(void)onClickEvent:(UIButton *) btn
{
    switch (btn.tag) {
        case 0:
        {
            NSLog(@"收付款");
            TCPaymentReceivedController *payVC =[[TCPaymentReceivedController alloc] init];
            [self.navigationController pushViewController:payVC animated:YES];
            break;
        }
        case 1:
        {
            NSLog(@"零钱");
            break;
        }
        case 2:
        {
            NSLog(@"银行卡");
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
   
    return 4;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MQCollectionViewCell *cell = (MQCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderColor=DEFAULT_BACKGROUND_COLOR.CGColor;
    cell.layer.borderWidth=0.5;
    
    NSArray *titles=@[@"淘金呗",@"萌免金融",@"GO商店",@"同城GO"];
    NSArray *images=@[@"gold",@"finance",@"shoping",@"go"];
    
    cell.imgView.image =[UIImage imageNamed:images[indexPath.row]];
    cell.text.text = titles[indexPath.row];
    return cell;
}

-(BOOL) collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-  (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}

//设置顶部的大小
-(CGSize)collectionView:(UICollectionView *)collectionViewlayout:(UICollectionViewLayout*)collectionViewLayoutreferenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={0,0};
    return size;
}
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionViewlayout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake(80,80);
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath:%@",indexPath);
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
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
