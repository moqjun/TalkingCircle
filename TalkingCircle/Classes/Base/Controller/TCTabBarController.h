//
//  ADTabBarController.h
//

#import <UIKit/UIKit.h>
#import "TCBaseNavigationController.h"

typedef NS_ENUM(NSInteger, kADTabBarItemType)
{
    ///首页
    kADTabBarItemTypeHome = 0,
    ///控制台
    kADTabBarItemTypeConsole = 1,
    ///通讯录
    kADTabBarItemTypeContact = 2,
    ///我的
    kADTabBarItemTypeMe = 3
};

@interface TCTabBarController : UITabBarController<UITabBarControllerDelegate>

- (TCBaseNavigationController *)currentVisableNavigationController;

- (TCBaseNavigationController *)visableNavigationControllerWithIndex:(NSInteger)index;

@end
