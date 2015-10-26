import std.stdio;

import card;
import deck;
import classifier;

void main(string[] args){
  int trials = 100000;

  int[string] hand_tally = [
    "Straight Flush": 0, 
    "Flush" : 0,
    "Four of a Kind" : 0,
    "Full House" : 0,
    "Two Pairs" : 0,
    "One Pair" : 0,
    "High Card" : 0
  ];

  for(int indx = 0; indx < trials; indx++){
    string hand_type;
    Card[] new_deck;
    new_deck = generate_deck;
    shuffle(new_deck);
    Card[] new_hand = new_deck[0..5];
    hand_type = classify(new_hand); 

    hand_tally[hand_type] = hand_tally[hand_type] + 1;
  }

  writeln("Straight Flush: ", hand_tally["Straight Flush"]);
  writeln("Four of a Kind: ", hand_tally["Four of a Kind"]);
  writeln("Full House: ", hand_tally["Full House"]);
  writeln("Flush: ", hand_tally["Flush"]);
  writeln("Two Pair: ", hand_tally["Two Pairs"]);
  writeln("One Pair: ", hand_tally["One Pair"]);
  writeln("High Card: ", hand_tally["High Card"]);
}


