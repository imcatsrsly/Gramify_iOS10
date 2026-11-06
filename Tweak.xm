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

%hook SHFeedCell

- (void)layoutSubviews {
    %orig;

    self.backgroundColor = [UIColor whiteColor];
    self.headerView.hidden = YES;

    self.avatarView.layer.cornerRadius = self.avatarView.bounds.size.width / 2.0;
    self.avatarView.clipsToBounds = YES;

    self.usernameLabel.font = [UIFont boldSystemFontOfSize:14];
    self.usernameLabel.textColor = [UIColor blackColor];

    self.clockView.hidden = YES;
    self.timeLabel.hidden = YES;

    self.likeButton.tintColor = [UIColor blackColor];
    self.commentButton.tintColor = [UIColor blackColor];
    self.shareButton.tintColor = [UIColor blackColor];
    self.saveButton.tintColor = [UIColor blackColor];

    self.likesHeart.tintColor = [UIColor blackColor];
    self.likesLabel.font = [UIFont boldSystemFontOfSize:14];
    self.likesLabel.textColor = [UIColor blackColor];

    self.captionLabel.font = [UIFont systemFontOfSize:14];
    self.captionLabel.textColor = [UIColor blackColor];

    self.groove.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
}

%end

%hook SHFeedViewController

- (void)viewDidLoad {
    %orig;

    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    titleLabel.text = @"Instagram";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Snell Roundhand" size:30] ?: [UIFont italicSystemFontOfSize:26];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
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
