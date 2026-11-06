#import <UIKit/UIKit.h>

@interface SHLoginViewController : UIViewController
@end

%hook SHLoginViewController

- (void)viewDidLoad {
    %orig;
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.6 blue:1.0 alpha:1.0];
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 40)];
    testLabel.text = @"Reskin tweak is working";
    testLabel.textColor = [UIColor whiteColor];
    testLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:testLabel];
}

%end
