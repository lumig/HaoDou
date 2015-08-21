//
//  EScrollerView.m
//  icoiniPad
//
//  Created by Ethan on 12-11-24.
//
//

#import "EScrollerView.h"
#import "UIImageView+AFNetworking.h"


#define kWitdh self.frame.size.width
#define kGreen [UIColor colorWithRed:102/255.0f green:153/255.0f blue:0.0f alpha:1]

@implementation EScrollerView


@synthesize delegate;

- (void)dealloc
{
	[scrollView release];
    [noteTitle release];
	delegate=nil;
    
    if (pageControl)
    {
        [pageControl release];
    }
    if (imageArray) {
        [imageArray release];
        imageArray=nil;
    }
    if (titleArray) {
        [titleArray release];
        titleArray=nil;
    }
    [super dealloc];
}

- (id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr autoPlay:(BOOL)autoPlay
{
	if ((self=[super initWithFrame:rect]))
    {
        self.userInteractionEnabled=YES;
        
        
        isRefresh = NO;
        
        titleArray=[titArr retain];
        
        
        NSMutableArray *tempArray=[NSMutableArray arrayWithArray:imgArr];
        [tempArray insertObject:[imgArr objectAtIndex:([imgArr count]-1)] atIndex:0];
        [tempArray addObject:[imgArr objectAtIndex:0]];
        
		imageArray=[[NSArray arrayWithArray:tempArray] retain];
        
		viewSize=rect;
        
        NSUInteger pageCount=[imageArray count];
        
        allPageSize = pageCount;
        
        
        scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
        scrollView.pagingEnabled = YES;
        
        scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
        
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        
        for (int i=0; i < pageCount; i++)
        {
            NSString *imgURL=[imageArray objectAtIndex:i];
            
            UIImageView *imgView=[[[UIImageView alloc] init] autorelease];
            if ([imgURL hasPrefix:@"http://"])
            {
                //网络图片 请使用ego异步图片库
//                [imgView setImageWithURL:[NSURL URLWithString:imgURL]];
//                [imgView setImageWithURL:[NSURL URLWithString:imgURL]];
//                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL]];
                [imgView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:nil];
            }
            else
            {
                UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
                [imgView setImage:img];
            }
            
            [imgView setFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width, viewSize.size.height)];
            
            imgView.tag = i;
            
            UITapGestureRecognizer *Tap =[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)] autorelease];
            [Tap setNumberOfTapsRequired:1];
            [Tap setNumberOfTouchesRequired:1];
            imgView.userInteractionEnabled=YES;
            [imgView addGestureRecognizer:Tap];
            [scrollView addSubview:imgView];
        }
        [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        [self addSubview:scrollView];
        
        //说明文字层
        UIView *noteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-33,self.bounds.size.width,33)];
        [noteView setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5]];
        //清除说明文字层的背景颜色
        [noteView setBackgroundColor:[UIColor clearColor]];
        float pageControlWidth=(pageCount-2)*10.0f+40.f;
        float pagecontrolHeight=20.0f;
        //修改pagecontrol的位置
//        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-pageControlWidth),6, pageControlWidth, pagecontrolHeight)];
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width-pageControlWidth)/2.0f,6, pageControlWidth, pagecontrolHeight + 5)];
        pageControl.currentPage=0;
        pageControl.numberOfPages=(pageCount-2);
        //
        pageControl.currentPageIndicatorTintColor = kGreen;
        [noteView addSubview:pageControl];
        
        noteTitle=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.frame.size.width-pageControlWidth-15, 20)];
        [noteTitle setText:[titleArray objectAtIndex:0]];
        [noteTitle setBackgroundColor:[UIColor clearColor]];
        [noteTitle setFont:[UIFont systemFontOfSize:13]];
        [noteView addSubview:noteTitle];
        
        [self addSubview:noteView];
        [noteView release];
        
        if (autoPlay)
        {
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
        }
        
       
	}
	return self;
}


- (void)changeView
{
    if (!isRefresh)
    {
        NSUInteger page = pageControl.currentPage;
        
        if (page == ([imageArray count]-3))
        {
            [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0) animated:YES];
            pageControl.currentPage = 0;
        }
        else
        {
            ++page;
            
            [scrollView setContentOffset:CGPointMake(viewSize.size.width * (page+1), 0) animated:YES];
            pageControl.currentPage = page;
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    isRefresh = YES;
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    currentPageIndex=page;
    
    pageControl.currentPage=(page-1);
    
    int titleIndex=page-1;
    if (titleIndex==[titleArray count]) {
        titleIndex=0;
    }
    if (titleIndex<0)
    {
        titleIndex= (int)[titleArray count]-1;
    }
    
    [noteTitle setText:[titleArray objectAtIndex:titleIndex]];
    isRefresh = NO;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    isRefresh = YES;
    
    if (currentPageIndex == 0)
    {
        [_scrollView setContentOffset:CGPointMake(([imageArray count]-2) * viewSize.size.width, 0)];
    }
    
    if (currentPageIndex==([imageArray count]-1))
    {
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
    }

    isRefresh = NO;
}
- (void)imagePressed:(UITapGestureRecognizer *)sender
{

    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        [delegate EScrollerViewDidClicked:sender.view.tag];
    }
}

@end
