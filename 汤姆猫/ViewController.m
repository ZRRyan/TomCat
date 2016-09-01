//
//  ViewController.m
//  汤姆猫
//
//  Created by Ryan on 15/8/18.
//  Copyright (c) 2015年 Ryan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 喝 */
- (IBAction)drink:(id)sender;
/** 点头 */
- (IBAction)knock:(id)sender;
/** 敲左脚 */
- (IBAction)knockLeftFoot:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


/** 方法抽取：把相同的代码拷贝过来，不同的东西通过参数传入 */

- (void)runAnimateWithCount:(NSInteger)count andImageName:(NSString *)name {
    
    // 如果正在执行动画就不要执行了
     if (self.imageView.isAnimating) return;
    
    // 创建可变数组
    NSMutableArray *images = [NSMutableArray array];
    // 往数组中添加图片
    for (int index = 0; index < count; index++) {
        // 图片名称
        NSString *imageName = [NSString stringWithFormat:@"%@_%02d",name,index];
        // 创建图片 (默认是有缓存的)
        // UIImage *image = [UIImage imageNamed:imageName];
        // 通过imageNamed创建的图片，存放在缓存中
       
        // imageWithContentsOfFile 不带缓存
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        
        // 图片加入数组
        [images addObject:image];
    }
    
    // 将图片赋值给imageView动画数组（真动画）
    self.imageView.animationImages = images;
    // 动画重复次数
    self.imageView.animationRepeatCount = 1;
    
    // 整个动画播放一圈的时间
    self.imageView.animationDuration = count * 0.05;
    
    // 开始播放动画
    [self.imageView startAnimating];
    
    // 清空animationImages的时间为动画执行完毕0.1秒
    CGFloat delay = self.imageView.animationDuration  + 0.1;
    // 延迟执行方法
//    [self performSelector:@selector(clearImages) withObject:nil afterDelay:delay];
    
    [self.imageView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:delay];
}

- (void) clearImages {
    // 清空animationImages中的图片
    self.imageView.animationImages = nil;
}

- (IBAction)drink:(id)sender {
    
//    if (self.imageView.isAnimating) return;
    
    [self runAnimateWithCount:81 andImageName:@"drink"];
    
    
}

- (IBAction)knock:(id)sender {
    
//    if (self.imageView.isAnimating) return;
    
    [self runAnimateWithCount:81 andImageName:@"knockout"];
}

- (IBAction)knockLeftFoot:(id)sender {
//    if (self.imageView.isAnimating) return;
    
    [self runAnimateWithCount:30 andImageName:@"footLeft"];
    }
@end
