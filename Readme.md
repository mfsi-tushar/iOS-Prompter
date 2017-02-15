Prompter
===================

An objective C implementation for custom style alert by  https://github.com/JastAir/Snackbar-iOS. 


Usage
-------------

Simply import the 2 files (Prompter.h and Prompter.m) to your project.


Example
-------------

Alloc init the Prompter and then call the method required.

``` objc
Prompter* prompterAlert = [[Prompter alloc] init];
[prompterAlert prepareSnackbarWithAction:^{
        NSLog(@"Button was tapped.");
    } andText:[NSString stringWithFormat:@"This is a message! :)"] buttonTitle:@"Tap Here!"];
```
That's All!

