//
//  ViewController.m
//  SJZRoute
//
//  Created by SJZ on 2019/3/28.
//  Copyright © 2019 SJZ. All rights reserved.
//

#import "ViewController.h"
#import "SJZRouteWorker.h"

#import <objc/runtime.h>
#import <objc/message.h>
#import "SJZInvoker.h"

@interface ViewController ()

@property (nonatomic, strong) NSString * str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SJZInvoker invoke:self selector:@"sjzsjz"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    id ss = [SJZRouteWorker createInstance:@"ViewController" selector:@"sjz" selArguments:nil withParams:nil];
    NSLog(@"%@", ss);
}

+ (instancetype)sjz {
    ViewController * ctr = [[ViewController alloc] init];
    return ctr;
}

- (void)sjzsjz {
    NSLog(@"shaojiazuo");
}

@end
