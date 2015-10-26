module card;

import std.stdio;

struct Card {
  string suit;
  string rank;
}

void print_card(Card card){
  writeln(card.rank, " of ", card.suit);
}

void print_hand(Card[] hand){
  foreach (card; hand){
    print_card(card);
  }
}

