//
//  Prompter.h
//  Snackbar
//
//  Created by Tushar Mohan on 10/02/17.
//  Copyright © 2017 Tushar Mohan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^ActionBlock)();

typedef enum : NSUInteger
{
    ELong,
    EShort
} EAnimationDuration;

@interface Prompter : NSObject

- (void)prepareWithText:(NSString*) detailText;
- (void)prepareSnackbarWithAction:(ActionBlock)actionBlock andText:(NSString*)detailText buttonTitle:(NSString*)aTitle;

@end
