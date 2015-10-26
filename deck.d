module deck;

import card;
import std.stdio;
import std.random;
import std.conv;

string[4] SUITS = [ "Diamonds", "Clubs", "Hearts", "Spades" ];

string[13] RANKS = ["Ace", "2", "3", "4", "5", "6", "7",
  "8", "9", "10", "Jack", "Queen", "King"
];

Card[] generate_deck()
{
  Card[] output;
  foreach (suit; SUITS) {
    foreach (rank; RANKS) {
      Card new_card = Card(suit, rank);
      output ~= new_card; 
    }
  }
  return output;
}

void shuffle(ref Card[] deck)
{
  int num_of_cards = to!int(deck.length);
  for(int indx = 0; indx < num_of_cards; indx++){
    int rand_indx = uniform(0, num_of_cards - 1);
    Card temp_card = deck[rand_indx];
    deck[rand_indx] = deck[indx];
    deck[indx] = temp_card;
  }
}

