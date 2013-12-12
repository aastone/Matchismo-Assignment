//
//  Deck.h
//  Matchismo
//
//  Created by wangyipu on 13-11-28.
//  Copyright (c) 2013年 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
