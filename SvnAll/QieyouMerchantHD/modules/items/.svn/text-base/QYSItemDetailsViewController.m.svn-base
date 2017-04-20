//
//  QYSItemDetailsViewController.m
//  QieYouShop
//
//  Created by Vincent on 1/30/15.
//  Copyright (c) 2015 CoderFly. All rights reserved.
//

#import "QYSItemDetailsViewController.h"
#import "QYSItemDetailsGroupDataSource.h"
#import "QYSItemDetailsDataSource.h"
#import "QYSOrderSubmitViewController.h"
#import "QYSLoginViewController.h"
#import "OrderIdManager.h"

#pragma mark - QYSItemDetailsViewController

@interface QYSItemDetailsViewController ()
{
    CGContextRef _renderContext;
    void *_vImageRenderBuffer;
}

@property (nonatomic, assign) UITableView *itemsGroupTableView;
@property (nonatomic, assign) UITableView *detailsTableView;
@property (nonatomic, strong) UIView *quickBar;
@property (nonatomic, strong) UILabel *quickTitleLabel;
@property (nonatomic, strong) UIButton *quickBuyButton;

@property (nonatomic, strong) QYSItemDetailsGroupDataSource *groupDataSource;
@property (nonatomic, strong) QYSItemDetailsDataSource *detailsDataSource;

@property (nonatomic, strong) CALayer *backgroundLayer;
@property (nonatomic, assign) CGFloat renderAlpha;

@end

@implementation QYSItemDetailsViewController

- (void)dealloc
{
    [self.backgroundLayer removeFromSuperlayer];
    
    CGContextRelease(_renderContext);
    
    free(_vImageRenderBuffer);
    _vImageRenderBuffer = NULL;
    _itemsGroupTableView = nil;
    _detailsTableView = nil;
    _quickBar = nil;
    _quickTitleLabel = nil;
    _quickBuyButton = nil;
    _groupDataSource = nil;
    _detailsDataSource = nil;
    _backgroundLayer = nil;
    
}

+ (UINavigationController *)navController
{
    QYSItemDetailsViewController *c = [[QYSItemDetailsViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:c];
    return nc;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack title:@"返回" target:self action:@selector(btnBackClick)];
        
        self.groupDataSource = [[QYSItemDetailsGroupDataSource alloc] init];
        self.detailsDataSource = [[QYSItemDetailsDataSource alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTitleTheme];
    UILabel *lb = (UILabel *)self.navigationItem.titleView;
    lb.font = FONT_WITH_SIZE(21);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar-empty-bg"] forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.alpha = 0.0;
    self.view.backgroundColor = COLOR_MAIN_GREEN;
    
    self.backgroundLayer = [CALayer layer];
    _backgroundLayer.frame = [QYSConfigs screenRect];
    _backgroundLayer.contents = (__bridge id)_backgroundImage.CGImage;
    _backgroundLayer.delegate = self;
    [self.view.layer addSublayer:_backgroundLayer];
    
    UIImageView *bv = [[UIImageView alloc] initWithFrame:[QYSConfigs screenRect]];
    [self.view addSubview:bv];
    
    [_groupDataSource setupTableView];
    self.itemsGroupTableView = _groupDataSource.tableView;
    [self.view addSubview:_itemsGroupTableView];
    _itemsGroupTableView.alpha = 0.0;
    _groupDataSource.productId =_productId;
    
    OrderIdManager *orderIdManager = [OrderIdManager sharedOrderIdManager];
    orderIdManager.orderId = _productId;
    
    [_detailsDataSource setupTableView];
    self.detailsTableView = _detailsDataSource.tableView;
    [_detailsTableView scrollRectToVisible:CGRectMake(0, -300, 300, 300) animated:NO];
    _detailsDataSource.actDelegate = self;
    [self.view addSubview:_detailsTableView];
    _detailsTableView.alpha = 0.0;
    _detailsDataSource.productId = _productId;
    
       __weak QYSItemDetailsViewController *weakSelf = self;
    
    [_detailsDataSource setChangeBuyButtonStateBlock:^(BOOL buyEnable) {
        weakSelf.quickBuyButton.enabled = buyEnable;
        if (buyEnable) {
            weakSelf.quickBuyButton.backgroundColor = COLOR_RGBA(1.0, 0.44, 0.15, 1.0);
            [weakSelf.quickBuyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        }else {
            weakSelf.quickBuyButton.backgroundColor = [UIColor grayColor];
            [weakSelf.quickBuyButton setTitle:@"售罄" forState:UIControlStateNormal];
        }
    }];
    
    [_detailsDataSource setChangeBuyButtonStateCancelBlock:^{
         weakSelf.quickBuyButton.enabled = NO;
        weakSelf.quickBuyButton.backgroundColor = [UIColor grayColor];
        [weakSelf.quickBuyButton setTitle:@"已下架" forState:UIControlStateNormal];
    }];
    
 
    [_groupDataSource setLeftListClickedBlock:^(Good *good) {
//        [weakSelf.detailsDataSource setupTableView];
        weakSelf.detailsDataSource.productId = good.product_id;
    }];
    
    self.quickBar = [[UIView alloc] init];
    _quickBar.translatesAutoresizingMaskIntoConstraints = NO;
    _quickBar.backgroundColor = COLOR_RGBA(0.0, 0.0, 0.0, 0.6);
    _quickBar.alpha = 0.0;
    [self.view addSubview:_quickBar];
    
    self.quickTitleLabel = [[UILabel alloc] init];
    _quickTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _quickTitleLabel.font = FONT_WITH_SIZE(24.0);
    _quickTitleLabel.textColor = COLOR_MAIN_WHITE;
    _quickTitleLabel.text = _good.product_name;
    [_quickBar addSubview:_quickTitleLabel];
    
    self.quickBuyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _quickBuyButton.translatesAutoresizingMaskIntoConstraints = NO;
    _quickBuyButton.backgroundColor = COLOR_RGBA(1.0, 0.44, 0.15, 1.0);
    _quickBuyButton.titleLabel.font = FONT_WITH_SIZE(24);
    [_quickBuyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [_quickBuyButton setTitleColor:COLOR_MAIN_WHITE forState:UIControlStateNormal];
    [_quickBuyButton addTarget:self action:@selector(btnBuyClick) forControlEvents:UIControlEventTouchUpInside];
    [_quickBar addSubview:_quickBuyButton];
    
    NSDictionary *dvs = NSDictionaryOfVariableBindings(_itemsGroupTableView, _detailsTableView, _quickBar, _quickTitleLabel, _quickBuyButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_itemsGroupTableView(321)]-42-[_detailsTableView]-41-|" options:0 metrics:nil views:dvs]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_itemsGroupTableView]-5-|" options:0 metrics:nil views:dvs]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_detailsTableView]-5-|" options:0 metrics:nil views:dvs]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_itemsGroupTableView][_quickBar]|" options:0 metrics:nil views:dvs]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_quickBar(60)]" options:0 metrics:nil views:dvs]];
    
    [_quickBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[_quickTitleLabel]-[_quickBuyButton(170)]|" options:0 metrics:nil views:dvs]];
    [_quickBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_quickTitleLabel]|" options:0 metrics:nil views:dvs]];
    [_quickBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_quickBuyButton]|" options:0 metrics:nil views:dvs]];
    
    if (IS_LESS_THAN_IOS7)
    {
        self.navigationController.navigationBar.alpha = 1.0;
        self.itemsGroupTableView.alpha = 1.0;
        self.detailsTableView.alpha = 1.0;
        self.backgroundImage = nil;
    }
}

#pragma mark -

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (!backgroundImage)
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIGraphicsBeginImageContextWithOptions([QYSConfigs screenSize], YES, 2.0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        if (IS_LESS_THAN_IOS7)
        {
            if (UIDeviceOrientationLandscapeLeft == [UIDevice currentDevice].orientation)
            {
                CGContextRotateCTM(ctx, -M_PI_2);
                CGContextTranslateCTM(ctx, -[QYSConfigs screenSize].height, 0);
            }
            else
            {
                CGContextRotateCTM(ctx, M_PI_2);
                CGContextTranslateCTM(ctx, 0, -[QYSConfigs screenSize].width);
            }
        }
        
        [window.layer renderInContext:ctx];
        UIImage *im = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _backgroundImage = im;
        
        if (IS_LESS_THAN_IOS7)
        {
            CGImageRef cg_im = _backgroundImage.CGImage;
            CGDataProviderRef cg_data_provider_ref = CGImageGetDataProvider(cg_im);
            CFDataRef im_data_ref = CGDataProviderCopyData(cg_data_provider_ref);
            
            vImage_Buffer src;
            src.data = (void *)CFDataGetBytePtr(im_data_ref);
            src.width = CGImageGetWidth(cg_im);
            src.height = CGImageGetHeight(cg_im);
            src.rowBytes = CGImageGetBytesPerRow(cg_im);
            
            void *tmp_buffer = (void *)malloc(src.height*src.rowBytes);
            _vImageRenderBuffer = (void *)malloc(src.height*src.rowBytes);
            _renderContext = CGBitmapContextCreate(_vImageRenderBuffer, src.width, src.height, CGImageGetBitsPerComponent(cg_im), CGImageGetBytesPerRow(cg_im), CGImageGetColorSpace(cg_im), CGImageGetBitmapInfo(cg_im));
            
            vImage_Buffer dest;
            dest.data = _vImageRenderBuffer;
            dest.width = src.width;
            dest.height = src.height;
            dest.rowBytes = src.rowBytes;
            
            unsigned char bg_color[4] = {1, 1, 1, 1};
            vImageBoxConvolve_ARGB8888(&src, &dest, tmp_buffer, 0, 0, 13, 13, bg_color, kvImageBackgroundColorFill);
            
            free(tmp_buffer);
            
            CGContextSetFillColorWithColor(_renderContext, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7].CGColor);
            CGContextFillRect(_renderContext, CGRectMake(0, 0, src.width, src.height));
            
            cg_im = CGBitmapContextCreateImage(_renderContext);
            _backgroundImage = [UIImage imageWithCGImage:cg_im];
            CGImageRelease(cg_im);
            
            CFRelease(im_data_ref);
        }
        
        return;
    }
    
    _backgroundImage = backgroundImage;
    
    //    EAGLContext *gl_ctx = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    //    CIContext *ci_ctx = [CIContext contextWithEAGLContext:gl_ctx];
    //
    //    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    //    [filter setDefaults];
    //
    //        //blur
    //    CIImage *ci_im_in = [CIImage imageWithCGImage:backgroundImage.CGImage];
    //    [filter setValue:ci_im_in forKey:kCIInputImageKey];
    //    [filter setValue:@4.5 forKey:kCIInputRadiusKey];
    //    CIImage *ci_im_out = [filter outputImage];
    //
    //        //brightness
    ////    filter = [CIFilter filterWithName:@"CIColorControls"];
    ////    [filter setDefaults];
    ////    [filter setValue:ci_im_out forKey:kCIInputImageKey];
    ////    [filter setValue:@-0.5 forKey:kCIInputBrightnessKey];
    ////    ci_im_out = [filter outputImage];
    //
    //    CGImageRef cg_img = [ci_ctx createCGImage:ci_im_out fromRect:ci_im_out.extent];
    //    _backgroundImage =  [UIImage imageWithCGImage:cg_img];
    //    CGImageRelease(cg_img);
}

- (void)showBackgroundLayerWithAnimate
{
    if (IS_LESS_THAN_IOS7)
    {
        return;
    }
    
    _renderAlpha = 0.0;
    
    CGImageRef cg_im = _backgroundImage.CGImage;
    CGDataProviderRef cg_data_provider_ref = CGImageGetDataProvider(cg_im);
    CFDataRef im_data_ref = CGDataProviderCopyData(cg_data_provider_ref);
    
    vImage_Buffer src;
    src.data = (void *)CFDataGetBytePtr(im_data_ref);
    src.width = CGImageGetWidth(cg_im);
    src.height = CGImageGetHeight(cg_im);
    src.rowBytes = CGImageGetBytesPerRow(cg_im);
    
    void *tmp_buffer = (void *)malloc(src.height*src.rowBytes);
    _vImageRenderBuffer = (void *)malloc(src.height*src.rowBytes);
    _renderContext = CGBitmapContextCreate(_vImageRenderBuffer, src.width, src.height, CGImageGetBitsPerComponent(cg_im), CGImageGetBytesPerRow(cg_im), CGImageGetColorSpace(cg_im), CGImageGetBitmapInfo(cg_im));
    
    vImage_Buffer dest;
    dest.data = _vImageRenderBuffer;
    dest.width = src.width;
    dest.height = src.height;
    dest.rowBytes = src.rowBytes;
    
    __block uint32_t kw = 3;
    __block uint32_t kh = 3;
    
    __weak QYSItemDetailsViewController *weak_self = self;
    
    float dt = 1.0/30.0;
    __block int step = (int)(0.25/dt);
    float alpha_step = 0.7/(float)step;
    static unsigned char bg_color[4] = {1, 1, 1, 1};
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, dt * NSEC_PER_SEC, 1ull * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        vImageBoxConvolve_ARGB8888(&src, &dest, tmp_buffer, 0, 0, kw, kh, bg_color, kvImageBackgroundColorFill);
        [weak_self.backgroundLayer setNeedsDisplay];
        
        kw += 2;
        kh += 2;
        step--;
        weak_self.renderAlpha += alpha_step;
        
        if (0 >= step)
        {
            dispatch_suspend(timer);
            free(tmp_buffer);
            
            [weak_self.navigationController setNavigationBarHidden:NO animated:YES];
            [UIView animateWithDuration:0.15
                             animations:^{
                                 weak_self.navigationController.navigationBar.alpha = 1.0;
                                 weak_self.itemsGroupTableView.alpha = 1.0;
                                 weak_self.detailsTableView.alpha = 1.0;
                                 weak_self.backgroundImage = nil;
                                 CFRelease(im_data_ref);
                             }];
        }
    });
    
    dispatch_resume(timer);
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextSaveGState(ctx);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, layer.bounds.size.height*-1.0);
    
    CGImageRef cg_im = CGBitmapContextCreateImage(_renderContext);
    CGContextDrawImage(ctx, layer.bounds, cg_im);
    CGImageRelease(cg_im);
    
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:_renderAlpha].CGColor);
    CGContextFillRect(ctx, layer.bounds);
    
    CGContextRestoreGState(ctx);
}

#pragma mark -

-(void) validateLoginComplete:(void(^)())completeBlock errror:(void(^)(NSString *error))errorBlock{
    if (![LoginService isLogin]) {
        QYSLoginViewController *c = [[QYSLoginViewController alloc] initWithNibName:nil bundle:nil];
        c.view.frame = CGRectMake(0, 0, 434, 344);
        
        QYSPopupView *pop_view = [[QYSPopupView alloc] init];
        pop_view.contentViewController = c;
        pop_view.contentView = c.view;
        pop_view.contentAlign = QYSPopupViewContentAlignCenter;
        [pop_view show];
        
        [c setCloseBlock:^(QYSLoginViewController *controller) {
            [pop_view hide:YES complete:nil];
        }];
        
        [c setLoginCompleteBlock:^(QYSLoginViewController *controller, NSString *error) {
            [pop_view hide:YES complete:^{
                
                if ([error isValid] && ![error isBlank]) {
                    //说明此时登陆失败了
                    errorBlock(error);
                    return ;
                }
                completeBlock();
                
            }];
        }];
        
        [c setFindPasswordBlock:^(QYSLoginViewController *controller) {
            [pop_view hide:YES complete:nil];
        }];
        
        return;
    }
    
    completeBlock();
}

- (void)btnBackClick
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)btnBuyClick
{
    [self validateLoginComplete:^{
        OrderIdManager *orderIdManager = [OrderIdManager sharedOrderIdManager];
        UINavigationController *c = [QYSOrderSubmitViewController navControllerWithProductId:orderIdManager.orderId];
        [self.navigationController presentViewController:c animated:YES completion:nil];
    } errror:^(NSString *error) {
        
    }];
    
}

#pragma mark -

- (void)hideQuickBar:(BOOL)hide
{
    CGFloat v = 0.0;
    
    if (!hide)
    {
        v = 1.0;
    }
    
    [UIView animateWithDuration:0.35
                     animations:^{
                         self.quickBar.alpha = v;
                     }];
}

@end
