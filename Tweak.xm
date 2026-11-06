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
@property (nonatomic, retain) UILabel *likesLabel;
@property (nonatomic, retain) UILabel *captionLabel;
@property (nonatomic, retain) UIView *groove;
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

    self.usernameLabel.font = [UIFont boldSystemFontOfSize:13];
    self.usernameLabel.textColor = [UIColor blackColor];

    self.clockView.hidden = YES;
    self.timeLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    self.timeLabel.font = [UIFont systemFontOfSize:12];

    self.likeButton.tintColor = [UIColor blackColor];
    self.commentButton.tintColor = [UIColor blackColor];
    self.shareButton.tintColor = [UIColor blackColor];
    self.saveButton.tintColor = [UIColor blackColor];

    self.likesLabel.font = [UIFont boldSystemFontOfSize:13];
    self.likesLabel.textColor = [UIColor blackColor];

    self.captionLabel.font = [UIFont systemFontOfSize:13];
    self.captionLabel.textColor = [UIColor blackColor];

    self.groove.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
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
