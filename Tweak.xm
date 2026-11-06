#import <UIKit/UIKit.h>

@interface SHFeedCell : UITableViewCell
@property (nonatomic, retain) UIImageView *headerView;
@property (nonatomic, retain) UIImageView *avatarView;
@property (nonatomic, retain) UILabel *usernameLabel;
@property (nonatomic, retain) UIImageView *clockView;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UIButton *likeButton;
@property (nonatomic, retain) UIButton *commentButton;
@property (nonatomic, retain) UIButton *shareButton;
@property (nonatomic, retain) UIButton *saveButton;
@property (nonatomic, retain) UIImageView *likesHeart;
@property (nonatomic, retain) UILabel *likesLabel;
@property (nonatomic, retain) UILabel *captionLabel;
@property (nonatomic, retain) UIView *groove;
@end

@interface SHFeedViewController : UIViewController
@property (nonatomic, retain) UITableView *tableView;
@end

@interface SHMainTabController : UITabBarController
@end

static void restyleButton(UIButton *button) {
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderWidth = 0;
    UIImage *img = [button imageForState:UIControlStateNormal];
    if (img) {
        [button setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    button.tintColor = [UIColor blackColor];
}

%hook SHFeedCell

- (void)layoutSubviews {
    %orig;

    self.backgroundColor = [UIColor whiteColor];

    // headerView оказался контейнером для аватарки/юзернейма, а не просто текстурой —
    // не прячем его целиком, а просто убираем тёмный фон/текстуру
    self.headerView.image = nil;
    self.headerView.backgroundColor = [UIColor whiteColor];

    self.avatarView.layer.cornerRadius = self.avatarView.bounds.size.width / 2.0;
    self.avatarView.clipsToBounds = YES;

    self.usernameLabel.font = [UIFont boldSystemFontOfSize:14];
    self.usernameLabel.textColor = [UIColor blackColor];

    self.clockView.hidden = YES;
    self.timeLabel.hidden = YES;

    restyleButton(self.likeButton);
    restyleButton(self.commentButton);
    restyleButton(self.shareButton);
    restyleButton(self.saveButton);

    self.likesHeart.tintColor = [UIColor blackColor];
    self.likesLabel.font = [UIFont boldSystemFontOfSize:14];
    self.likesLabel.textColor = [UIColor blackColor];

    self.captionLabel.font = [UIFont systemFontOfSize:14];
    self.captionLabel.textColor = [UIColor blackColor];

    self.groove.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
}

%end

%hook SHMainTabController

- (void)viewDidLoad {
    %orig;
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.translucent = NO;
}

%end

// --- Диагностика: распечатываем реальную иерархию вью в файл,
// чтобы найти настоящий класс тёмной верхней панели ---

static void dumpViews(UIView *view, NSMutableString *out, NSInteger depth) {
    NSString *indent = [@"" stringByPaddingToLength:depth*2 withString:@" " startingAtIndex:0];
    [out appendFormat:@"%@%@  frame=%@\n", indent, NSStringFromClass([view class]), NSStringFromCGRect(view.frame)];
    for (UIView *sub in view.subviews) {
        dumpViews(sub, out, depth+1);
    }
}

%hook SHFeedViewController

- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSMutableString *out = [NSMutableString string];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    dumpViews(window, out, 0);
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gramify_dump.txt"];
    [out writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

%end
