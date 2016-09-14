//
//  ViewController.m
//  wifi_modu
//
//  Created by jinou on 16/7/15.
//  Copyright © 2016年 qcy.jinou. All rights reserved.
//

#import "ViewController.h"
#import "SimplePing.h"

static NSString *hostName = @"www.baidu.com";

@interface ViewController ()<SimplePingDelegate>


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createPingObject];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)createPingObject
{
    SimplePing *pinger = [[SimplePing alloc] initWithHostName:hostName];
    pinger.delegate = self;
    pinger.addressStyle = SimplePingAddressStyleICMPv4;
    [pinger start];
}

/**
 *  start成功，也就是准备工作做完后的回调
 */
- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address
{
    // 发送测试报文数据
    [pinger sendPingWithData:nil];
}
- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    [pinger stop];
    [pinger start];
}

// 发送测试报文成功的回调方法
- (void)simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
    NSLog(@"#%u sent", sequenceNumber);
}

//发送测试报文失败的回调方法
- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error
{
    NSLog(@"#%u send failed: %@", sequenceNumber, error);
}

// 接收到ping的地址所返回的数据报文回调方法
- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
    NSLog(@"#%u received, size=%zu", sequenceNumber, packet.length);
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet
{
    NSLog(@"#%s",__func__);
}

@end
