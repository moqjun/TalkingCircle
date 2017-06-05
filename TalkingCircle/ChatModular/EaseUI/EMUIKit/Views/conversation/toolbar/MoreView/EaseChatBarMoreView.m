/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseChatBarMoreView.h"
#import "UIButton+Extend.h"

#define CHAT_BUTTON_SIZE 60
#define INSETS 10
#define MOREVIEW_COL 4
#define MOREVIEW_ROW 2
#define MOREVIEW_BUTTON_TAG 1000
#define Button_ImageAndTextSpace 4

@implementation UIView (MoreView)

- (void)removeAllSubview
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end

@interface EaseChatBarMoreView ()<UIScrollViewDelegate,UIActionSheetDelegate>
{
    EMChatToolbarType _type;
    NSInteger _maxIndex;
}

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) TCUpDownButton *photoButton;
@property (nonatomic, strong) TCUpDownButton *takePicButton;
@property (nonatomic, strong) TCUpDownButton *locationButton;
@property (nonatomic, strong) TCUpDownButton *videoButton;
@property (nonatomic, strong) TCUpDownButton *audioCallButton;
@property (nonatomic, strong) TCUpDownButton *videoCallButton;

//名片
@property (nonatomic, strong) TCUpDownButton *cardButton;

//红包
@property (nonatomic, strong) TCUpDownButton *redPacketButton;


@end

@implementation EaseChatBarMoreView

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseChatBarMoreView *moreView = [self appearance];
    moreView.moreViewBackgroundColor = [UIColor whiteColor];
}

- (instancetype)initWithFrame:(CGRect)frame type:(EMChatToolbarType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = type;
        [self setupSubviewsForType:_type];
    }
    return self;
}

- (void)setupSubviewsForType:(EMChatToolbarType)type
{
    self.backgroundColor = [UIColor colorWithUInt:0xf8f8f8];
    self.accessibilityIdentifier = @"more_view";
    
    _scrollview = [[UIScrollView alloc] init];
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.delegate = self;
    [self addSubview:_scrollview];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 1;
    [self addSubview:_pageControl];
    
    CGFloat insets = (self.frame.size.width - 4 * CHAT_BUTTON_SIZE) / 5;
    
    _photoButton = [[TCUpDownButton alloc] initWithFrame:CGRectMake(insets, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    _photoButton.imageAndTextSpace = Button_ImageAndTextSpace;
    [_photoButton setTitle:@"相册" forState:UIControlStateNormal];
    [_photoButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
    _photoButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _photoButton.accessibilityIdentifier = @"image";
    [_photoButton setImage:[UIImage imageNamed:@"chat_send_img"] forState:UIControlStateNormal];
    [_photoButton setImage:[UIImage imageNamed:@"chat_send_img"] forState:UIControlStateHighlighted];
    [_photoButton addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    _photoButton.tag = MOREVIEW_BUTTON_TAG;
    [_scrollview addSubview:_photoButton];
    
    _takePicButton =[[TCUpDownButton alloc] initWithFrame:CGRectMake(insets * 2 + CHAT_BUTTON_SIZE, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    _takePicButton.imageAndTextSpace = Button_ImageAndTextSpace;
    [_takePicButton setTitle:@"拍摄" forState:UIControlStateNormal];
    [_takePicButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
    _takePicButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_takePicButton setImage:[UIImage imageNamed:@"chat_send_screen"] forState:UIControlStateNormal];
    [_takePicButton setImage:[UIImage imageNamed:@"chat_send_screen"] forState:UIControlStateHighlighted];
    [_takePicButton addTarget:self action:@selector(takePicAction) forControlEvents:UIControlEventTouchUpInside];
    _takePicButton.tag = MOREVIEW_BUTTON_TAG + 1;
    [_scrollview addSubview:_takePicButton];
    

    CGRect frame = self.frame;
    if (type == EMChatToolbarTypeChat) {
        frame.size.height = 170;
        
        _videoCallButton = [[TCUpDownButton alloc] initWithFrame:CGRectMake(insets * 3 + CHAT_BUTTON_SIZE * 2, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        _videoCallButton.imageAndTextSpace = Button_ImageAndTextSpace;
        [_videoCallButton setTitle:@"视频" forState:UIControlStateNormal];
        [_videoCallButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
        _videoCallButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_videoCallButton setImage:[UIImage imageNamed:@"chat_send_video"] forState:UIControlStateNormal];
        [_videoCallButton setImage:[UIImage imageNamed:@"chat_send_video"] forState:UIControlStateHighlighted];
        [_videoCallButton addTarget:self action:@selector(takeVideoCallAction) forControlEvents:UIControlEventTouchUpInside];
        _videoCallButton.tag =MOREVIEW_BUTTON_TAG + 2;
        [_scrollview addSubview:_videoCallButton];
        
        
        _redPacketButton = [[TCUpDownButton alloc] initWithFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        _redPacketButton.imageAndTextSpace = Button_ImageAndTextSpace;
        [_redPacketButton setTitle:@"红包" forState:UIControlStateNormal];
        [_redPacketButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
        _redPacketButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_redPacketButton setImage:[UIImage imageNamed:@"chat_send_reward"] forState:UIControlStateNormal];
        [_redPacketButton setImage:[UIImage imageNamed:@"chat_send_reward"] forState:UIControlStateHighlighted];
        [_redPacketButton addTarget:self action:@selector(redpacketCallAction) forControlEvents:UIControlEventTouchUpInside];
        _redPacketButton.tag =MOREVIEW_BUTTON_TAG + 3;
        [_scrollview addSubview:_redPacketButton];
        
//        _audioCallButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        [_audioCallButton setFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
//        [_audioCallButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/chatBar_colorMore_audioCall"] forState:UIControlStateNormal];
//        [_audioCallButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/chatBar_colorMore_audioCallSelected"] forState:UIControlStateHighlighted];
//        [_audioCallButton addTarget:self action:@selector(takeAudioCallAction) forControlEvents:UIControlEventTouchUpInside];
//        _audioCallButton.tag = MOREVIEW_BUTTON_TAG + 3;
//        [_scrollview addSubview:_audioCallButton];
        
        
        _locationButton = [[TCUpDownButton alloc] initWithFrame:CGRectMake(insets, 10 * 2 + CHAT_BUTTON_SIZE + 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        _locationButton.imageAndTextSpace = Button_ImageAndTextSpace;
        [_locationButton setTitle:@"位置" forState:UIControlStateNormal];
        [_locationButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
        _locationButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _locationButton.accessibilityIdentifier = @"location";
        [_locationButton setImage:[UIImage imageNamed:@"chat_send_loc"] forState:UIControlStateNormal];
        [_locationButton setImage:[UIImage imageNamed:@"chat_send_loc"] forState:UIControlStateHighlighted];
        [_locationButton addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
        _locationButton.tag = MOREVIEW_BUTTON_TAG + 4;
        [_scrollview addSubview:_locationButton];
        
        _cardButton = [[TCUpDownButton alloc] initWithFrame:CGRectMake(insets * 2 + CHAT_BUTTON_SIZE, 10 * 2 + CHAT_BUTTON_SIZE + 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
         _cardButton.imageAndTextSpace = Button_ImageAndTextSpace;
        [_cardButton setTitle:@"名片" forState:UIControlStateNormal];
        [_cardButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
        _cardButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_cardButton setImage:[UIImage imageNamed:@"chat_send_card"] forState:UIControlStateNormal];
        [_cardButton setImage:[UIImage imageNamed:@"chat_send_card"] forState:UIControlStateHighlighted];
      //  [_cardButton addTarget:self action:@selector(sendCardAction) forControlEvents:UIControlEventTouchUpInside];
        _cardButton.tag = MOREVIEW_BUTTON_TAG + 5;
        [_scrollview addSubview:_cardButton];
        
        _maxIndex = 5;
    }
    else if (type == EMChatToolbarTypeGroup)
    {
        frame.size.height = 170;
        
        _redPacketButton = [[TCUpDownButton alloc] initWithFrame:CGRectMake(insets * 3 + CHAT_BUTTON_SIZE * 2, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        _redPacketButton.imageAndTextSpace = Button_ImageAndTextSpace;
        [_redPacketButton setTitle:@"红包" forState:UIControlStateNormal];
        [_redPacketButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
        _redPacketButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_redPacketButton setImage:[UIImage imageNamed:@"chat_send_reward"] forState:UIControlStateNormal];
        [_redPacketButton setImage:[UIImage imageNamed:@"chat_send_reward"] forState:UIControlStateHighlighted];
        [_redPacketButton addTarget:self action:@selector(redpacketCallAction) forControlEvents:UIControlEventTouchUpInside];
        _redPacketButton.tag =MOREVIEW_BUTTON_TAG + 2;
        [_scrollview addSubview:_redPacketButton];
        

        _locationButton = [[TCUpDownButton alloc] initWithFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        _locationButton.imageAndTextSpace = Button_ImageAndTextSpace;
        [_locationButton setTitle:@"位置" forState:UIControlStateNormal];
        [_locationButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
        _locationButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _locationButton.accessibilityIdentifier = @"location";
        [_locationButton setImage:[UIImage imageNamed:@"chat_send_loc"] forState:UIControlStateNormal];
        [_locationButton setImage:[UIImage imageNamed:@"chat_send_loc"] forState:UIControlStateHighlighted];
        [_locationButton addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
        _locationButton.tag = MOREVIEW_BUTTON_TAG + 3;
        [_scrollview addSubview:_locationButton];
        
        _cardButton = [[TCUpDownButton alloc] initWithFrame:CGRectMake(insets, 10 * 2 + CHAT_BUTTON_SIZE + 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
        _cardButton.imageAndTextSpace = Button_ImageAndTextSpace;
        [_cardButton setTitle:@"名片" forState:UIControlStateNormal];
        [_cardButton setTitleColor:[UIColor colorWithUInt:0x979797] forState:UIControlStateNormal];
        _cardButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_cardButton setImage:[UIImage imageNamed:@"chat_send_card"] forState:UIControlStateNormal];
        [_cardButton setImage:[UIImage imageNamed:@"chat_send_card"] forState:UIControlStateHighlighted];
        [_cardButton addTarget:self action:@selector(sendCardAction) forControlEvents:UIControlEventTouchUpInside];
        _cardButton.tag = MOREVIEW_BUTTON_TAG + 4;
        [_scrollview addSubview:_cardButton];
        
        _maxIndex = 4;
        
    }
    self.frame = frame;
    _scrollview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(frame) - 20, CGRectGetWidth(frame), 20);
    _pageControl.hidden = _pageControl.numberOfPages<=1;
}

- (void)insertItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highLightedImage title:(NSString *)title
{
    CGFloat insets = (self.frame.size.width - MOREVIEW_COL * CHAT_BUTTON_SIZE) / 5;
    CGRect frame = self.frame;
    _maxIndex++;
    NSInteger pageSize = MOREVIEW_COL*MOREVIEW_ROW;
    NSInteger page = _maxIndex/pageSize;
    NSInteger row = (_maxIndex%pageSize)/MOREVIEW_COL;
    NSInteger col = _maxIndex%MOREVIEW_COL;
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setFrame:CGRectMake(page * CGRectGetWidth(self.frame) + insets * (col + 1) + CHAT_BUTTON_SIZE * col, INSETS + INSETS * 2 * row + CHAT_BUTTON_SIZE * row, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [moreButton setImage:image forState:UIControlStateNormal];
    [moreButton setImage:highLightedImage forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    moreButton.tag = MOREVIEW_BUTTON_TAG+_maxIndex;
    [_scrollview addSubview:moreButton];
    [_scrollview setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * (page + 1), CGRectGetHeight(self.frame))];
    [_pageControl setNumberOfPages:page + 1];
    if (_maxIndex >=5) {
        frame.size.height = 150;
        _scrollview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        _pageControl.frame = CGRectMake(0, CGRectGetHeight(frame) - 20, CGRectGetWidth(frame), 20);
    }
    self.frame = frame;
    _pageControl.hidden = _pageControl.numberOfPages<=1;
}

- (void)updateItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highLightedImage title:(NSString *)title atIndex:(NSInteger)index
{
    UIView *moreButton = [_scrollview viewWithTag:MOREVIEW_BUTTON_TAG+index];
    if (moreButton && [moreButton isKindOfClass:[UIButton class]]) {
        [(UIButton*)moreButton setImage:image forState:UIControlStateNormal];
        [(UIButton*)moreButton setImage:highLightedImage forState:UIControlStateHighlighted];
    }
}

- (void)removeItematIndex:(NSInteger)index
{
    UIView *moreButton = [_scrollview viewWithTag:MOREVIEW_BUTTON_TAG+index];
    if (moreButton && [moreButton isKindOfClass:[UIButton class]]) {
        [self _resetItemFromIndex:index];
        [moreButton removeFromSuperview];
    }
}

#pragma mark - private

- (void)_resetItemFromIndex:(NSInteger)index
{
    CGFloat insets = (self.frame.size.width - MOREVIEW_COL * CHAT_BUTTON_SIZE) / 5;
    CGRect frame = self.frame;
    for (NSInteger i = index + 1; i<_maxIndex + 1; i++) {
        UIView *moreButton = [_scrollview viewWithTag:MOREVIEW_BUTTON_TAG+i];
        if (moreButton && [moreButton isKindOfClass:[UIButton class]]) {
            NSInteger moveToIndex = i - 1;
            NSInteger pageSize = MOREVIEW_COL*MOREVIEW_ROW;
            NSInteger page = moveToIndex/pageSize;
            NSInteger row = (moveToIndex%pageSize)/MOREVIEW_COL;
            NSInteger col = moveToIndex%MOREVIEW_COL;
            [moreButton setFrame:CGRectMake(page * CGRectGetWidth(self.frame) + insets * (col + 1) + CHAT_BUTTON_SIZE * col, INSETS + INSETS * 2 * row + CHAT_BUTTON_SIZE * row, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
            moreButton.tag = MOREVIEW_BUTTON_TAG+moveToIndex;
            [_scrollview setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * (page + 1), CGRectGetHeight(self.frame))];
            [_pageControl setNumberOfPages:page + 1];
        }
    }
    _maxIndex--;
    if (_maxIndex >=5) {
        frame.size.height = 150;
    } else {
        frame.size.height = 80;
    }
    self.frame = frame;
    _scrollview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(frame) - 20, CGRectGetWidth(frame), 20);
    _pageControl.hidden = _pageControl.numberOfPages<=1;
}

#pragma setter
//- (void)setMoreViewColumn:(NSInteger)moreViewColumn
//{
//    if (_moreViewColumn != moreViewColumn) {
//        _moreViewColumn = moreViewColumn;
//        [self setupSubviewsForType:_type];
//    }
//}
//
//- (void)setMoreViewNumber:(NSInteger)moreViewNumber
//{
//    if (_moreViewNumber != moreViewNumber) {
//        _moreViewNumber = moreViewNumber;
//        [self setupSubviewsForType:_type];
//    }
//}

- (void)setMoreViewBackgroundColor:(UIColor *)moreViewBackgroundColor
{
    _moreViewBackgroundColor = moreViewBackgroundColor;
    if (_moreViewBackgroundColor) {
        [self setBackgroundColor:_moreViewBackgroundColor];
    }
}

/*
- (void)setMoreViewButtonImages:(NSArray *)moreViewButtonImages
{
    _moreViewButtonImages = moreViewButtonImages;
    if ([_moreViewButtonImages count] > 0) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                if (button.tag < [_moreViewButtonImages count]) {
                    NSString *imageName = [_moreViewButtonImages objectAtIndex:button.tag];
                    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                }
            }
        }
    }
}

- (void)setMoreViewButtonHignlightImages:(NSArray *)moreViewButtonHignlightImages
{
    _moreViewButtonHignlightImages = moreViewButtonHignlightImages;
    if ([_moreViewButtonHignlightImages count] > 0) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                if (button.tag < [_moreViewButtonHignlightImages count]) {
                    NSString *imageName = [_moreViewButtonHignlightImages objectAtIndex:button.tag];
                    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
                }
            }
        }
    }
}*/

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset =  scrollView.contentOffset;
    if (offset.x == 0) {
        _pageControl.currentPage = 0;
    } else {
        int page = offset.x / CGRectGetWidth(scrollView.frame);
        _pageControl.currentPage = page;
    }
}

#pragma mark - action

- (void)takePicAction{
    if(_delegate && [_delegate respondsToSelector:@selector(moreViewTakePicAction:)]){
        [_delegate moreViewTakePicAction:self];
    }
}

- (void)photoAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewPhotoAction:)]) {
        [_delegate moreViewPhotoAction:self];
    }
}

- (void)locationAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewLocationAction:)]) {
        [_delegate moreViewLocationAction:self];
    }
}

- (void)takeAudioCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewAudioCallAction:)]) {
        [_delegate moreViewAudioCallAction:self];
    }
}

- (void)takeVideoCallAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:@"视频聊天",@"语音聊天", nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
//    if (_delegate && [_delegate respondsToSelector:@selector(moreViewVideoCallAction:)]) {
//        [_delegate moreViewVideoCallAction:self];
//    }
}

- (void)sendCardAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewCardAction:)]) {
        [_delegate moreViewCardAction:self];
    }
}

- (void)redpacketCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewReadPacketAction:)]) {
        [_delegate moreViewReadPacketAction:self];
    }
}

- (void)moreAction:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if (button && _delegate && [_delegate respondsToSelector:@selector(moreView:didItemInMoreViewAtIndex:)]) {
        [_delegate moreView:self didItemInMoreViewAtIndex:button.tag-MOREVIEW_BUTTON_TAG];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(moreViewVideoCallAction:)]) {
            [_delegate moreViewVideoCallAction:self];
        }
    } else if (buttonIndex == 1) {
        if (_delegate && [_delegate respondsToSelector:@selector(moreViewAudioCallAction:)]) {
            [_delegate moreViewAudioCallAction:self];
        }
        
    }
}


@end
