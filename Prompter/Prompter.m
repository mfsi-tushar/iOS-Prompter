//
//  Prompter.m
//  Snackbar
//
//  Created by Tushar Mohan on 10/02/17.
//  Copyright © 2017 Tushar Mohan. All rights reserved.
//

#import "Prompter.h"

#define kKeyWindow [[UIApplication sharedApplication] keyWindow]

@interface Prompter ()
{
    UIView*  _snackbarView;
    
    UIColor* _backgroundColor;
    UIColor* _textColor;
    UIColor* _buttonColor;
    UIColor* _buttonColorPressed;
    
    CGFloat  _snackbarHeight;
    
    EAnimationDuration _animationDuration;
    
    ActionBlock _action;
    
    UIWindow* _keyWindow;
}
@property UILabel* textHolder;
@property UIButton* button;
@end

@implementation Prompter
- (instancetype)init
{
   self = [super init];
    
    if(!self)
        return nil;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rotate)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    _snackbarView       = [[UIView alloc] initWithFrame:CGRectZero];
    _backgroundColor    = [UIColor darkGrayColor];
    _textColor          = [UIColor whiteColor];
    _buttonColor        = [UIColor cyanColor];
    _buttonColorPressed = [UIColor grayColor];
    _animationDuration  = EShort;
    _textHolder         = [[UILabel alloc]init];
    _button             = [[UIButton alloc]init];
    _snackbarHeight     = 65.0f;
    _keyWindow          = kKeyWindow;
    
    return self;
}

- (void)rotate
{
    _snackbarView.frame = CGRectMake(0, _keyWindow.frame.size.height - _snackbarHeight, _keyWindow.frame.size.width, _snackbarHeight);
    
    _button.frame = CGRectMake(_keyWindow.frame.size.width * 0.73, 0,_keyWindow.frame.size.width * 0.25, _snackbarHeight);
}

- (void)prepareWithText:(NSString*) detailText
{
    [self setupSnackbarView];
    
    _textHolder.text = detailText;
    _textHolder.textColor = _textColor;
    _textHolder.frame = CGRectMake(_keyWindow.frame.size.width * 0.05, 0, _keyWindow.frame.size.width * 0.95, _snackbarHeight);
    
    [_snackbarView addSubview:_textHolder];
    [self show];
}

- (void)prepareSnackbarWithAction:(ActionBlock)actionBlock andText:(NSString*)detailText buttonTitle:(NSString*)aTitle
{
    _action = actionBlock;
    [self setupSnackbarView];
    
    _textHolder.text = detailText;
    _textHolder.textColor = _textColor;
    _textHolder.frame = CGRectMake(_keyWindow.frame.size.width * 0.05, 0, _keyWindow.frame.size.width * 0.75, _snackbarHeight);
    [_snackbarView addSubview:_textHolder];
    
    [_button setTitleColor:_buttonColor forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_button setTitle:aTitle forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(actionButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_button setFrame:CGRectMake(_keyWindow.frame.size.width * 0.73, 0, _keyWindow.frame.size.width * 0.25, _snackbarHeight)];
    [_snackbarView addSubview:_button];
    
    [self show];
}

- (void)setupSnackbarView
{
    [_keyWindow addSubview:_snackbarView];
    
    _snackbarView.frame = CGRectMake(0, _keyWindow.frame.size.height, _keyWindow.frame.size.width, _snackbarHeight);
    _snackbarView.backgroundColor = _backgroundColor;
    
}

- (void)show
{
    switch (_animationDuration)
    {
    case EShort:
            [self animateBar:2.0f];
            break;
        
    case ELong:
            [self animateBar:3.0f];
            break;
    }
}

- (void)animateBar:(float)timerLength
{
    [UIView animateWithDuration:0.4f animations:^{
        _snackbarView.frame = CGRectMake(0, _keyWindow.frame.size.height - _snackbarHeight, _keyWindow.frame.size.width, _snackbarHeight);
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:timerLength target:self selector:@selector(hide) userInfo:nil repeats:NO];
    
}

- (void)actionButtonPressed
{
    _action();
    [self hide];
}

- (void)hide
{
    [UIView animateWithDuration:0.4f animations:^{
        _snackbarView.frame = CGRectMake(0, _keyWindow.frame.size.height , _keyWindow.frame.size.width, _snackbarHeight);
    } completion:^(BOOL finished) {
        [_snackbarView removeFromSuperview];
    }];
}

- (void)dealloc
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}
@end
