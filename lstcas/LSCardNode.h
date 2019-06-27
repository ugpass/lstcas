//
//  LSCardNode.h
//  lstcas
//
//  Created by fwj on 2019/6/27.
//  Copyright © 2019年 ls. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "LSTCModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LSCardNode : ASCellNode

- (instancetype)initWithTcmodel:(LSTCModel *)model;

@end

NS_ASSUME_NONNULL_END
