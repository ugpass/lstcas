//
//  LSCardNode.m
//  lstcas
//
//  Created by fwj on 2019/6/27.
//  Copyright © 2019年 ls. All rights reserved.
//

#import "LSCardNode.h"

@interface LSCardNode()
@property (nonatomic, strong)LSTCModel *model;

@property (nonatomic, strong)ASNetworkImageNode *bigImageNode;
@property (nonatomic, strong)ASNetworkImageNode *smallImageNode;
@property (nonatomic, strong)ASTextNode *tagNode;
@property (nonatomic, strong)ASTextNode *detailTagNode;
@end

@interface LSCardNode(ASNetworkImageNodeDelegate)<ASNetworkImageNodeDelegate>

@end

@implementation LSCardNode

- (instancetype)initWithTcmodel:(LSTCModel *)model{
    if (self = [super init]) {
        _model = model;
        
        _bigImageNode = [[ASNetworkImageNode alloc] init];
        _bigImageNode.URL = [NSURL URLWithString:model.icon_name];
        _bigImageNode.delegate = self;
        _bigImageNode.placeholderFadeDuration = 0.15;
        _bigImageNode.contentMode = UIViewContentModeScaleAspectFill;
        
        _smallImageNode = [[ASNetworkImageNode alloc] init];
        _smallImageNode.URL = [NSURL URLWithString:model.small_icon_url];
        _smallImageNode.delegate = self;
        _smallImageNode.placeholderFadeDuration = 0.15;
        _smallImageNode.contentMode = UIViewContentModeScaleAspectFill;
        
        _tagNode.attributedText = [NSAttributedString attributedStringForTitleText:model.tag_name];
        
        _detailTagNode.attributedText = [NSAttributedString attributedStringForTitleText:model.tag_introduce];
        
        [self addSubnode:_bigImageNode];
        [self addSubnode:_smallImageNode];
        [self addSubnode:_tagNode];
        [self addSubnode:_detailTagNode];
        
    }
    return self;
}

- (ASLayout *)layoutThatFits:(ASSizeRange)constrainedSize{
    
}

@end

@implementation LSCardNode(ASNetworkImageNodeDelegate)

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image{
    if ([imageNode isEqual:self.bigImageNode]) {
        self.bigImageNode.image = image;
    }else if ([imageNode isEqual:self.smallImageNode]) {
        self.smallImageNode.image = image;
    }else{
        NSLog(@"imageNode not found");
    }
    
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didFailWithError:(NSError *)error{
    NSLog(@"load image error");
}

- (void)imageNodeDidLoadImageFromCache:(ASNetworkImageNode *)imageNode{
    NSLog(@"load image from cache");
}

@end
