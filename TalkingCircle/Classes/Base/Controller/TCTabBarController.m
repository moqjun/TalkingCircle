//
//  ADTabBarController.m
//

#import "TCTabBarController.h"


#define kTabBarChatItemTag 1003
#define kDefaultIpImageWidth 42
#define kTabbarItemWidth (CGRectGetWidth(self.tabBar.bounds) / 4)

@interface TCTabBarController ()
//tabbarItem选中背景图
@property (nonatomic, readonly) UIImage *selectionIndicatorImage;
@property (nonatomic, assign) NSInteger lastIndex;

@end

@implementation TCTabBarController
@synthesize selectionIndicatorImage = _selectionIndicatorImage;

#pragma mark - 属性

- (UIImage *)selectionIndicatorImage
{
    if (!_selectionIndicatorImage)
    {
//        UIColor *color = [BMAppColor appDeepOrangeColor];
//        CGRect rect = CGRectMake(0, 0, kTabbarItemWidth, self.tabBar.height);
//        _selectionIndicatorImage = [self createTabbarbgImageWithColor:color andRect:rect];
    }
    return _selectionIndicatorImage;
}



///根据颜色、大小创建图片
- (UIImage *)createTabbarbgImageWithColor:(UIColor *)color andRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 生命周期

- (void)dealloc
{
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.lastIndex = 0;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
//    self.viewControllers = @[
//                             //首页
//                             [[ADBaseNavigationController alloc]initWithRootViewController:[[IndexViewController alloc]init]],
//                             //控制台
//
//                             [[ADBaseNavigationController alloc]initWithRootViewController:[[ADConsoleController alloc]init]],
//                             //通讯录
//                             [[ADBaseNavigationController alloc]initWithRootViewController:[[ContactIndexViewController alloc]init]],
//                             //我的
//                             [[ADBaseNavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]]
//                             ];
    self.selectedIndex = kADTabBarItemTypeHome;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initTabbarStyle];
    [self initTabBarItemStype];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    TCBaseNavigationController *navController = [self currentVisableNavigationController];
    return [navController.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    TCBaseNavigationController *navController = [self currentVisableNavigationController];
    return [navController.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - TabBar风格设置

///分割线
- (void)setDefaultSeperatorLineBgColor
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"a3a2a2"];
    [self.tabBar addSubview:lineView];
}

///初始化tabbar风格
- (void)initTabbarStyle
{
    UIColor *color = [UIColor colorWithHexString:@"141414"];
    CGRect rect = CGRectMake(0, 0, self.tabBar.width, self.tabBar.height);
    self.tabBar.backgroundImage = [self createTabbarbgImageWithColor:color andRect:rect];
    self.tabBar.selectionIndicatorImage = self.selectionIndicatorImage;
    [self setDefaultSeperatorLineBgColor];
}

///初始化tabbar item风格
- (void)initTabBarItemStype
{
    NSArray *titlesArray = @[@"首页",
                             @"控制台",
                             @"通讯录",
                             @"我的"];
    
    NSArray *itemIconArray =@[@"tab_bar_home",
                              @"tab_bar_kongzhi",
                              @"tab_bar_tongxunl",
                              @"tab_bar_wode"];
    
    NSArray *itemHoverIconArray = @[@"tab_bar_home_d",
                                    @"tab_bar_kongzhi_d",
                                    @"tab_bar_tongxunl_d",
                                    @"tab_bar_wode_d"];
    
    for (NSInteger index = 0; index < titlesArray.count; index ++)
    {
        UITabBarItem *item = [self.tabBar.items objectAtIndex:index];
        [item setTitle:titlesArray[index]];
        UIImage *normalImage = [UIImage imageNamed:itemIconArray[index]];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *hoverImage = [UIImage imageNamed:itemHoverIconArray[index]];
        hoverImage = [hoverImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

       
        [item setImage:normalImage];
        [item setSelectedImage:hoverImage];
    }
}



#pragma mark - TabBarController Delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    self.lastIndex = self.selectedIndex;
//    if ([viewController isKindOfClass:[ADBaseNavigationController class]])
//    {
//        NSArray *controllers = ((ADBaseNavigationController *)viewController).viewControllers;
//        UIViewController *topViewController = [controllers firstObject];
//        
//        ///首页
//        if ([topViewController isKindOfClass:[IndexViewController class]])
//        {
//           [((ADBaseNavigationController *)viewController) popToRootViewControllerAnimated:NO];
//        }
//        
//        ///控制台
//        
//        if ([topViewController isKindOfClass:[ADConsoleController class]])
//        {
//            [((ADBaseNavigationController *)viewController) popToRootViewControllerAnimated:NO];
//        }
//        
//        ///通讯录
//        if ([topViewController isKindOfClass:[ContactIndexViewController class]])
//        {
//           [((ADBaseNavigationController *)viewController) popToRootViewControllerAnimated:NO];
//        }
//        
//        ///我的
//        if ([topViewController isKindOfClass:[MainViewController class]])
//        {
//            [((ADBaseNavigationController *)viewController) popToRootViewControllerAnimated:NO];
//        }
    
    
      
//        self.tabBar.selectionIndicatorImage = self.selectionIndicatorImage;
//    }
    return YES;
}

//
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
  
}



- (TCBaseNavigationController *)currentVisableNavigationController
{
    TCBaseNavigationController *navigationController = nil;
    
    switch (self.selectedIndex)
    {
        case kADTabBarItemTypeHome:
        {
            navigationController = [self.viewControllers objectAtIndex:kADTabBarItemTypeHome];
            break;
        }
        case kADTabBarItemTypeConsole:
        {
            navigationController = [self.viewControllers objectAtIndex:kADTabBarItemTypeConsole];
            break;
        }
        case kADTabBarItemTypeContact:
        {
            navigationController = [self.viewControllers objectAtIndex:kADTabBarItemTypeContact];
            break;
        }
        case kADTabBarItemTypeMe:
        {
            navigationController = [self.viewControllers objectAtIndex:kADTabBarItemTypeMe];
            break;
        }
            
        default:
            break;
    }
    
    return navigationController;
}


- (TCBaseNavigationController *)visableNavigationControllerWithIndex:(NSInteger)index
{
    TCBaseNavigationController *navigationController = nil;
    
    switch (index)
    {
        case kADTabBarItemTypeHome:
        {
            navigationController = [self.viewControllers objectAtIndex:kADTabBarItemTypeHome];
            break;
        }
        case kADTabBarItemTypeConsole:
        {
            navigationController = [self.viewControllers objectAtIndex:kADTabBarItemTypeConsole];
            break;
        }
        case kADTabBarItemTypeContact:
        {
            navigationController = [self.viewControllers objectAtIndex:kADTabBarItemTypeContact];
            break;
        }
        case kADTabBarItemTypeMe:
        {
            navigationController = [self.viewControllers objectAtIndex:kADTabBarItemTypeMe];
            break;
        }
            
        default:
            break;
    }
    
    return navigationController;
}


@end
