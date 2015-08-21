//
//  DayCell.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-13.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "DayCell.h"
#import "UIImageView+AFNetworking.h"
#import "listInfo.h"
#import "contentInfo.h"

#define kHeight _allCommentLabel.frame.origin.y
@interface DayCell()
@property(nonatomic,strong) UIImage *diggImgNormal;
@property(nonatomic,strong) UIImage *connentImgNormal;
@property(nonatomic,strong) UIImage *shareImgNormal;
@end

@implementation DayCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //200
        _photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 200)];
        [self.contentView addSubview:_photoImgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired= 1;
        [_photoImgView addGestureRecognizer:tap];
        _photoImgView.tag = 1;
        //44
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.frame = CGRectMake(15, 200, kSize.width - 56, 44);
        [self.contentView addSubview:_titleBtn];
        [_titleBtn.titleLabel setFont: [UIFont systemFontOfSize:14]];
        _titleBtn.tag = 11;
        [_titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _arrowRightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kSize.width - 56, 200 + 9, 26, 26)];
        [_arrowRightImgView setImage:[UIImage imageNamed:@"ico_arrow_right.png"]];
        [self.contentView addSubview:_arrowRightImgView];
        
        //
        _diggImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, _titleBtn.frame.origin.y + 19 + 44, 16, 16)];
//        [_diggImgView setImage:[UIImage imageNamed:@"ico_prefix_good.png"]];
        [self.contentView addSubview:_diggImgView];
        
        _diggLabelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _diggLabelBtn.frame = CGRectMake(_diggImgView.frame.origin.x + 26, _titleBtn.frame.origin.y +44, 100, 44);
        _diggLabelBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_diggLabelBtn setTitleColor:kGreen forState:UIControlStateNormal];
        [_diggLabelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_diggLabelBtn];
        _diggLabelBtn.tag = 22;
        [_diggLabelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //
        _commentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, _titleBtn.frame.origin.y + 88 + 19, 16, 16)];
        [self.contentView addSubview:_commentImgView];
        
        //
        _connentLabelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _connentLabelBtn.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _diggBtn.frame.origin.y + 44, 100, 44);
        [self.contentView addSubview:_connentLabelBtn];
        _connentLabelBtn.tag = 33;
        [_connentLabelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //
        _introLab = [[UILabel alloc] initWithFrame:CGRectMake(_connentLabelBtn.frame.origin.x + _connentLabelBtn.frame.size.width, _diggBtn.frame.origin.y + 44, 100, 44)];
        _introLab.numberOfLines = 0;
        _introLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_introLab];
        
        //
        _allCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_commentImgView.frame.origin.x + 26, _introLab.frame.origin.y + _introLab.frame.size.height, kSize.width - 30, 44)];
        _allCommentLabel.textAlignment = NSTextAlignmentLeft;
        [_allCommentLabel setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:_allCommentLabel];
        
        //
        _userLabelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _userLabelBtn.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _allCommentLabel.frame.origin.y + 44, 100, 44);
        [_userLabelBtn setTitleColor:kGreen forState:UIControlStateNormal];
        [self.contentView addSubview:_userLabelBtn];
        _userLabelBtn.tag = 44;
        [_userLabelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_userLabelBtn.frame.origin.x + _userLabelBtn.frame.size.width, _userLabelBtn.frame.origin.y + _userLabelBtn.frame.size.height, kSize.width - 30, 200)];
        [_contentLabel setFont:[UIFont systemFontOfSize:14]];
        [_contentLabel setNumberOfLines:0];
        [self.contentView addSubview:_contentLabel];
        
        //
        UIImage *diggImgNormal = [UIImage imageNamed:@"btn_good.png"];
        UIImage *diggImgSelected = [UIImage imageNamed:@"btn_good_on.png"];
        _diggBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _diggBtn.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 15, diggImgNormal.size.width, diggImgNormal.size.height);
        [_diggBtn setBackgroundImage:diggImgNormal forState:UIControlStateNormal];
        [_diggBtn setBackgroundImage:diggImgSelected forState:UIControlStateSelected];
        [_diggBtn setTitle:@"  赞" forState:UIControlStateNormal];
        _diggBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_diggBtn setTitleColor:kGreen forState:UIControlStateNormal];
        _diggImgNormal = diggImgNormal;
        [_diggBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_diggBtn];
        _diggBtn.tag = 55;
        [_diggBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //
        UIImage *connentImgNormal = [UIImage imageNamed:@"btn_comment.png"];
        UIImage *connentImgSelected = [UIImage imageNamed:@"btn_comment_on.png"];
        _conntentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _conntentBtn.frame = CGRectMake(_diggBtn.frame.origin.x + _diggBtn.frame.size.width + 15, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 15, connentImgNormal.size.width, connentImgNormal.size.height);
        [_conntentBtn setBackgroundImage:connentImgNormal forState:UIControlStateNormal];
        [_conntentBtn setBackgroundImage:connentImgSelected forState:UIControlStateSelected];
        [_conntentBtn setTitle:@"      评论" forState:UIControlStateNormal];
        _conntentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_conntentBtn setTitleColor:kGreen forState:UIControlStateNormal];
        _connentImgNormal = connentImgNormal;
        [self.contentView addSubview:_conntentBtn];
        _conntentBtn.tag = 66;
        [_conntentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //
        UIImage *shareImgNormal = [UIImage imageNamed:@"btn_comment.png"];
        UIImage *shareImgSelected = [UIImage imageNamed:@"btn_comment_on.png"];
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(_conntentBtn.frame.origin.x + _conntentBtn.frame.size.width + 15, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 15, shareImgNormal.size.width, shareImgNormal.size.height);
        [_shareBtn setBackgroundImage:shareImgNormal forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:shareImgSelected forState:UIControlStateSelected];
        [_shareBtn setTitle:@"     分享" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_shareBtn setTitleColor:kGreen forState:UIControlStateNormal];
        _shareImgNormal = shareImgNormal;
        [self.contentView addSubview:_shareBtn];
        _shareBtn.tag = 77;
        [_shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
    
}

- (void)cellForFillListInfo:(listInfo *)info
{
    [_photoImgView setImageWithURL:[NSURL URLWithString:info.photoUrl] placeholderImage:nil];
    [_titleBtn setTitle:info.titleStr forState:UIControlStateNormal];
    CGSize titleSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize:14] text:info.timeStr];
    [_titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_titleBtn setFrame:CGRectMake(15, 200,titleSize.width + 50, 44)];
    CGSize topicSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 44) font:[UIFont systemFontOfSize:14] text:[NSString stringWithFormat:@"#%@#",info.topicName]];
    NSString *introStr = [NSString stringWithFormat:@"#%@# %@",info.topicName,info.intro];

    CGSize introSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize:14] text:introStr];

    if (info.titleStr.length < 1) {
        [_arrowRightImgView setHidden:YES];
        [_diggImgView setImage:[UIImage imageNamed:@"ico_prefix_good.png"]];
        _diggLabelBtn.frame = CGRectMake(_diggImgView.frame.origin.x , 200 + 50 , 100, 44);
        

        
    }
    else
    {
        _diggImgView.frame = CGRectMake(15, _titleBtn.frame.origin.y +44 + 14, 16, 16);
        [_diggImgView setImage:[UIImage imageNamed:@"ico_prefix_good.png"]];
        _diggLabelBtn.frame = CGRectMake(_diggImgView.frame.origin.x , _titleBtn.frame.origin.y +44, 100, 44);
    }
    _commentImgView.frame = CGRectMake(15, _titleBtn.frame.origin.y + 70 + 19, 16, 16);
    [_commentImgView setImage:[UIImage imageNamed:@"ico_prefix_comment.png"]];
    [_diggLabelBtn setTitle:[NSString stringWithFormat:@"%@次赞",info.commentCount] forState:UIControlStateNormal];

    [_connentLabelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_connentLabelBtn setTitleColor:kGreen forState:UIControlStateNormal];
    [_connentLabelBtn setTitle:[NSString stringWithFormat:@"#%@#",info.topicName] forState:UIControlStateNormal];
    
//    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:introStr];
//    
//    CGSize constraint = CGSizeMake(kSize.width - 30, 2000.0f);
//    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:introStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
//    CGSize introSize = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    if (info.intro.length < 1) {
        
       _allCommentLabel.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _connentLabelBtn.frame.origin.y + 44 , kSize.width - 30, 44);
        
        _diggBtn.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _commentImgView.frame.origin.y + _commentImgView.frame.size.height + 15, _diggImgNormal.size.width, _diggImgNormal.size.height);
        _conntentBtn.frame = CGRectMake(_diggBtn.frame.origin.x + _diggBtn.frame.size.width + 15, _commentImgView.frame.origin.y + _commentImgView.frame.size.height + 15, _connentImgNormal.size.width, _connentImgNormal.size.height);
        _shareBtn.frame = CGRectMake(_conntentBtn.frame.origin.x + _conntentBtn.frame.size.width + 15, _commentImgView.frame.origin.y + _commentImgView.frame.size.height + 15, _shareImgNormal.size.width, _shareImgNormal.size.height);
    }
    else
    {
    _introLab.frame = CGRectMake(_connentLabelBtn.frame.origin.x , _titleBtn.frame.origin.y + 70 + 19, kSize.width - 60, introSize.height);
//         _introLab.frame = CGRectMake(_diggImgView.frame.origin.x , _titleBtn.frame.origin.y + 70 + 19, kSize.width - 30 , introSize.height);
        
        _introLab.text = [NSString stringWithFormat:@"            %@",info.intro];
        _allCommentLabel.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _introLab.frame.origin.y + _introLab.frame.size.height, kSize.width - 30, 44);
    }
    _connentLabelBtn.frame = CGRectMake(_commentImgView.frame.origin.x + 30, _titleBtn.frame.origin.y + 55 + 19 , topicSize.width, 44);
    [_connentLabelBtn setTitleColor:kGreen forState:UIControlStateNormal];
    _allCommentLabel.text = [NSString stringWithFormat:@"查看所有%ld条评论",info.comment.count];
    [_allCommentLabel setFont:[UIFont systemFontOfSize:14]];
    
//    contentInfo *connInfo = [[contentInfo alloc] init];
    NSDictionary *dict = [[NSDictionary alloc] init];
    if (info.comment.count > 0) {
        dict = info.comment[0];

    }
    CGSize userSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize:14] text:[dict objectForKey:@"UserName"]];
    if ([dict objectForKey:@"Content"] == nil) {
        //
        
        _allCommentLabel.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _connentLabelBtn.frame.origin.y + 44 , kSize.width - 30, 44);

        _diggBtn.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _allCommentLabel.frame.origin.y + 44 + 15, _diggImgNormal.size.width, _diggImgNormal.size.height);
        _conntentBtn.frame = CGRectMake(_diggBtn.frame.origin.x + _diggBtn.frame.size.width + 15, _allCommentLabel.frame.origin.y +44 + 15, _connentImgNormal.size.width, _connentImgNormal.size.height);
        _shareBtn.frame = CGRectMake(_conntentBtn.frame.origin.x + _conntentBtn.frame.size.width + 15, _allCommentLabel.frame.origin.y + 44 + 15, _shareImgNormal.size.width, _shareImgNormal.size.height);
        
    }
    else
    {
    
    _userLabelBtn.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _allCommentLabel.frame.origin.y + 20, userSize.width, 44);
        _userLabelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _userLabelBtn.tag = 44;
    
    NSString *commStr = [NSString stringWithFormat:@"%@%@",[dict objectForKey:@"UserName"],[dict objectForKey:@"Content"]];
    CGSize commSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize: 14] text:commStr];
    _contentLabel.frame = CGRectMake(_userLabelBtn.frame.origin.x , _userLabelBtn.frame.origin.y + 14, kSize.width - 30, commSize.height);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame: CGRectMake(_commentImgView.frame.origin.x + 26, _allCommentLabel.frame.origin.y + 20, userSize.width, 44)];
        [imgView setImage:[UIImage imageNamed:@"white_bg.png"]];
        [self addSubview:_userLabelBtn];
        [_userLabelBtn setTitle:[dict objectForKey:@"UserName"] forState:UIControlStateNormal];
    _contentLabel.text = commStr;
    
    //three btn
    _diggBtn.frame = CGRectMake(_commentImgView.frame.origin.x + 26, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 15, _diggImgNormal.size.width, _diggImgNormal.size.height);
    _conntentBtn.frame = CGRectMake(_diggBtn.frame.origin.x + _diggBtn.frame.size.width + 15, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 15, _connentImgNormal.size.width, _connentImgNormal.size.height);
    _shareBtn.frame = CGRectMake(_conntentBtn.frame.origin.x + _conntentBtn.frame.size.width + 15, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 15, _shareImgNormal.size.width, _shareImgNormal.size.height);
    
    }

    
    
}

+ (CGSize)stringBoundingRectWithSize:(CGSize)contentSize font:(UIFont *)font text:(NSString *)text
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [paragraphStyle setLineSpacing:0];
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [text boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}

+ (CGFloat)heightForCommentInfo:(listInfo *)info
{
    if (info.titleStr.length < 1) {
        
        if (info.intro.length < 1) {
            
            if (info.comment.count > 0) {
//                contentInfo *connInfo = [[contentInfo alloc] init];
                NSDictionary *dict = [[NSDictionary alloc] init];
                dict = info.comment[0];
                NSString *commStr = [NSString stringWithFormat:@"%@%@",[dict objectForKey:@"userName"],[dict objectForKey:@"content"]];
                CGSize commSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize: 14] text:commStr];
                
                return 200 + 132 + commSize.height + 120;
            }
            else
            {
                return 200 + 132 + 120;
            }
        }
        else
        {
            NSString *introStr = [NSString stringWithFormat:@"#%@#%@",info.topicName,info.intro];

            CGSize introSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize:14] text:introStr];
            
            if (info.comment.count > 0) {
//                contentInfo *connInfo = [[contentInfo alloc] init];
                NSDictionary *dict = [NSDictionary dictionary];
                dict = info.comment[0];
                NSString *commStr = [NSString stringWithFormat:@"%@%@",[dict objectForKey:@"userName"],[dict objectForKey:@"content"]];
                CGSize commSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize: 14] text:commStr];
                
                return 200 + 132 +introSize.height + commSize.height + 120;
            }
            else
            {
                return 200 + 132 +introSize.height+ 120;
            }
        }

    }
    else
    {
    if (info.intro.length < 1) {
        
        if (info.comment.count > 0) {
//            contentInfo *connInfo = [[contentInfo alloc] init];
            NSDictionary *dict = [NSDictionary dictionary];
            dict = info.comment[0];
            NSString *commStr = [NSString stringWithFormat:@"%@%@",[dict objectForKey:@"userName"],[dict objectForKey:@"content"]];
            CGSize commSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize: 14] text:commStr];
            
            return 200 + 176 + commSize.height + 140;

        }
        else
        {
            return 200 + 176 + 140;
        }
    }
    else
    {
        NSString *introStr = [NSString stringWithFormat:@"#%@#%@",info.topicName,info.intro];
        
        CGSize introSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize:14] text:introStr];
        
        if (info.comment.count > 0) {
         
//            contentInfo *connInfo = [[contentInfo alloc] init];
//            connInfo = info.comment[0];
            NSDictionary *dict = [NSDictionary dictionary];
            dict = info.comment[0];
            NSString *commStr = [NSString stringWithFormat:@"%@%@",[dict objectForKey:@"userName"],[dict objectForKey:@"content"]];
            CGSize commSize = [DayCell stringBoundingRectWithSize:CGSizeMake(kSize.width - 30, 200) font:[UIFont systemFontOfSize: 14] text:commStr];
            
            return 200 + 176 +introSize.height + commSize.height + 120;
        }
        else
        {
            return 200 + 176 +introSize.height+ 120;

        }
    }
        
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class])isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)imageClick:(UITapGestureRecognizer *)sender
{
    if ([_delegate respondsToSelector:@selector(DayCellDidClicked:)]) {
        [_delegate DayCellDidClicked:sender.view.tag];
    }
}

- (void)btnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(dayCellBtnDidClicked:)]) {
        [_delegate dayCellBtnDidClicked:btn.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
