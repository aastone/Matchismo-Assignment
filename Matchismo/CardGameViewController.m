//
//  CardGameViewController.m
//  Matchismo
//
//  Created by wangyipu on 13-11-28.
//  Copyright (c) 2013年 stone. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
//@property (strong, nonatomic)Deck *deck;

//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;


@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) CardMatchingGame *newGame;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    
    return _game;
}

- (CardMatchingGame *)newGame
{
    
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    return _game;
}

//- (Deck *)deck
//{
//    if (!_deck) {
//        _deck = [self createDeck];
//    }
//    return _deck;
//}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}

//- (void)setFlipCount:(int)flipCount
//{
//    _flipCount = flipCount;
//    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
//}
- (IBAction)resetButton:(id)sender {
//    for (UIButton *cardButton in self.cardButtons) {
//        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
//        Card *card = [self.game cardAtIndex:cardButtonIndex];
//        
//        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardBack"] forState:UIControlStateNormal];
//        [cardButton setTitle:@"" forState:UIControlStateNormal];
//        cardButton.enabled = YES;
//        
//        self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
//    }
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game resetCards:chosenButtonIndex];
    [self resetUI];
    [self.newGame resetCards:chosenButtonIndex];
}

- (void)resetUI
{
    for (UIButton *cardButton in self.cardButtons) {
//        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardBack"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    }
}
- (IBAction)touchCardButton:(UIButton *)sender {
    
//    UIImage *cardImage = [UIImage imageNamed:@"cardBack"];
//    [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
    
//    if ([[sender currentTitle] length]) {
//        [sender setBackgroundImage:[UIImage imageNamed:@"cardBack"] forState:UIControlStateNormal];
//        [sender setTitle:@"" forState:UIControlStateNormal];
//    }else{
//        Card *randomCard = [self.deck drawRandomCard];
//        if (randomCard) {
//            [sender setBackgroundImage:[UIImage imageNamed:@"cardFront"] forState:UIControlStateNormal];
////            [sender setTitle:@"A♣️" forState:UIControlStateNormal];
////            [sender setTitle:randomCard.contents forState:UIControlStateNormal];
//            [sender setTitle:[randomCard contents] forState:UIControlStateNormal];
//        }
//        
//    }
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
//    self.flipCount++;
    
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    NSLog(@"%@",card.contents);
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    NSLog(@"cardfront");
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
