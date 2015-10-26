module classifier;

import card;
import std.conv;
import std.stdio;
import std.algorithm;

string classify(Card[] hand)
{
  if(all_same_suit(hand) && is_straight(hand))  
    return "Straight Flush";
  else if (all_same_suit(hand))
    return "Flush";
  else if (build_rank_tally(hand) == [1,4])
    return "Four of a Kind";
  else if (build_rank_tally(hand) == [2,3])
    return "Full House";
  else if (build_rank_tally(hand) == [1,2,2])
    return "Two Pairs";
  else if (build_rank_tally(hand) == [1,1,1,2])
    return "One Pair";
  else
    return "High Card";
}

unittest // classify
{
  Card[5] straight_flush;
  straight_flush[0] = Card("Clubs", "4");
  straight_flush[1] = Card("Clubs", "5");
  straight_flush[2] = Card("Clubs", "6");
  straight_flush[3] = Card("Clubs", "7");
  straight_flush[4] = Card("Clubs", "8");
  assert(classify(straight_flush) == "Straight Flush");

  Card[5] flush;
  flush[0] = Card("Clubs", "Jack");
  flush[1] = Card("Clubs", "5");
  flush[2] = Card("Clubs", "10");
  flush[3] = Card("Clubs", "7");
  flush[4] = Card("Clubs", "Queen");
  assert(classify(flush) == "Flush");

  Card[5] straight;
  straight[0] = Card("Hearts", "4");
  straight[1] = Card("Clubs", "5");
  straight[2] = Card("Spades", "6");
  straight[3] = Card("Diamonds", "7");
  straight[4] = Card("Clubs", "8");
  assert(classify(straight_flush) == "Straight Flush");

  Card[5] four_kind;
  four_kind[0] = Card("Hearts", "5");
  four_kind[1] = Card("Clubs", "5");
  four_kind[2] = Card("Spades", "5");
  four_kind[3] = Card("Diamonds", "5");
  four_kind[4] = Card("Clubs", "8");
  assert(classify(four_kind) == "Four of a Kind");

  Card[5] full_house;
  full_house[0] = Card("Hearts", "5");
  full_house[1] = Card("Clubs", "5");
  full_house[2] = Card("Spades", "8");
  full_house[3] = Card("Diamonds", "8");
  full_house[4] = Card("Clubs", "8");
  assert(classify(full_house) == "Full House");

  Card[5] two_pairs;
  two_pairs[0] = Card("Hearts", "5");
  two_pairs[1] = Card("Clubs", "5");
  two_pairs[2] = Card("Spades", "8");
  two_pairs[3] = Card("Diamonds", "8");
  two_pairs[4] = Card("Clubs", "King");
  assert(classify(two_pairs) == "Two Pairs");

  Card[5] one_pair;
  one_pair[0] = Card("Hearts", "5");
  one_pair[1] = Card("Clubs", "5");
  one_pair[2] = Card("Spades", "8");
  one_pair[3] = Card("Diamonds", "9");
  one_pair[4] = Card("Clubs", "King");
  assert(classify(one_pair) == "One Pair");

  Card[5] high_hand;
  high_hand[0] = Card("Clubs", "4");
  high_hand[1] = Card("Clubs", "5");
  high_hand[2] = Card("Hearts", "6");
  high_hand[3] = Card("Spades", "Jack");
  high_hand[4] = Card("Diamonds", "8");
  assert(classify(high_hand) == "High Card");
}

int[] build_rank_tally(Card[] hand)
{
  int[string] tally;
  foreach (card; hand) {
    if(card.rank in tally)
      tally[card.rank] = tally[card.rank]+1;
    else
      tally[card.rank] = 1;
  }
  int[] output = tally.values;
  sort(output);
  return output;
}

unittest // build_rank_tally
{
  Card[5] high_hand;
  high_hand[0] = Card("Clubs", "4");
  high_hand[1] = Card("Clubs", "5");
  high_hand[2] = Card("Hearts", "6");
  high_hand[3] = Card("Spades", "Jack");
  high_hand[4] = Card("Diamonds", "8");
  assert(build_rank_tally(high_hand) == [1,1,1,1,1]);

  Card[5] one_pair_hand;
  one_pair_hand[0] = Card("Clubs", "4");
  one_pair_hand[1] = Card("Hearts", "4");
  one_pair_hand[2] = Card("Hearts", "6");
  one_pair_hand[3] = Card("Spades", "Jack");
  one_pair_hand[4] = Card("Diamonds", "8");
  assert(build_rank_tally(one_pair_hand) == [1,1,1,2]);

  Card[5] two_pairs_hand;
  two_pairs_hand[0] = Card("Clubs", "4");
  two_pairs_hand[1] = Card("Hearts", "4");
  two_pairs_hand[2] = Card("Hearts", "Jack");
  two_pairs_hand[3] = Card("Spades", "Jack");
  two_pairs_hand[4] = Card("Diamonds", "8");
  assert(build_rank_tally(two_pairs_hand) == [1,2,2]);

  Card[5] four_kind_hand;
  four_kind_hand[0] = Card("Clubs", "4");
  four_kind_hand[1] = Card("Hearts", "4");
  four_kind_hand[2] = Card("Spades", "4");
  four_kind_hand[3] = Card("Diamonds", "4");
  four_kind_hand[4] = Card("Diamonds", "8");
  assert(build_rank_tally(four_kind_hand) == [1,4]);

  Card[5] full_house_hand;
  full_house_hand[0] = Card("Clubs", "4");
  full_house_hand[1] = Card("Hearts", "4");
  full_house_hand[2] = Card("Spades", "4");
  full_house_hand[3] = Card("Diamonds", "8");
  full_house_hand[4] = Card("Clubs", "8");
  assert(build_rank_tally(full_house_hand) == [2,3]);
}

bool is_straight(Card[] hand)
{
  bool output = true;
  int[] ranks = sorted_by_rank(hand);
  if(ranks == [1,10,11,12,13])
    return output;

  for(int indx = 0; indx < ranks.length - 1; indx++){
    if(ranks[indx] != (ranks[indx+1]-1))
      output = false;
  }
  return output;
}

unittest // is_straight
{
  Card[5] hand_straight;
  hand_straight[0] = Card("Clubs", "4");
  hand_straight[1] = Card("Clubs", "5");
  hand_straight[2] = Card("Hearts", "6");
  hand_straight[3] = Card("Spades", "7");
  hand_straight[4] = Card("Diamonds", "8");
  assert(is_straight(hand_straight) == true);

  Card[5] hand_not_straight;
  hand_not_straight[0] = Card("Clubs", "4");
  hand_not_straight[1] = Card("Clubs", "5");
  hand_not_straight[2] = Card("Hearts", "King");
  hand_not_straight[3] = Card("Spades", "7");
  hand_not_straight[4] = Card("Diamonds", "8");
  assert(is_straight(hand_not_straight) == false);

  Card[5] hand_straight_ace;
  hand_straight_ace[0] = Card("Clubs", "2");
  hand_straight_ace[1] = Card("Clubs", "4");
  hand_straight_ace[2] = Card("Hearts", "Ace");
  hand_straight_ace[3] = Card("Spades", "3");
  hand_straight_ace[4] = Card("Diamonds", "5");
  assert(is_straight(hand_straight_ace) == true);

  Card[5] hand_straight_royal;
  hand_straight_royal[0] = Card("Clubs", "10");
  hand_straight_royal[1] = Card("Clubs", "King");
  hand_straight_royal[2] = Card("Hearts", "Ace");
  hand_straight_royal[3] = Card("Spades", "Queen");
  hand_straight_royal[4] = Card("Diamonds", "Jack");
  assert(is_straight(hand_straight_royal) == true);
}

int[] sorted_by_rank(Card[] hand){
  int[] output;
  foreach (card; hand){
    output ~= rank_to_num(card.rank);
  }
  sort(output);
  return output;
}

unittest // sorted_by_rank
{
  int[] suits;
  Card[5] hand;
  hand[0] = Card("Clubs", "7");
  hand[1] = Card("Clubs", "5");
  hand[2] = Card("Hearts", "10");
  hand[3] = Card("Spades", "Queen");
  hand[4] = Card("Diamonds", "Ace");
  suits = sorted_by_rank(hand);
  assert(suits[0] == 1);
  assert(suits[1] == 5);
  assert(suits[2] == 7);
  assert(suits[3] == 10);
  assert(suits[4] == 12);
}

int rank_to_num(string rank)
{
  int output; 
  switch(rank) {
    case "Ace":
      output = 1;
      break;
    case "Jack":
      output = 11;
      break;
    case "Queen":
      output = 12;
      break;
    case "King":
      output = 13;
      break;
    default:
      output = to!int(rank);
      break;
  }
  return output;
}


bool all_same_suit(Card[] hand)
{
  bool output = true;
  string first_suit = hand[0].suit;
  foreach (card; hand){
    if(card.suit != first_suit)
      output = false;
  }
  return output;
}

unittest // all_same_suit
{
  Card[5] hand_diff_suits;
  hand_diff_suits[0] = Card("Clubs", "7");
  hand_diff_suits[1] = Card("Clubs", "5");
  hand_diff_suits[2] = Card("Hearts", "10");
  hand_diff_suits[3] = Card("Spades", "Queen");
  hand_diff_suits[4] = Card("Diamonds", "Ace");
  assert(all_same_suit(hand_diff_suits) == false);

  Card[5] hand_same_suits;
  hand_same_suits[0] = Card("Clubs", "7");
  hand_same_suits[1] = Card("Clubs", "5");
  hand_same_suits[2] = Card("Clubs", "10");
  hand_same_suits[3] = Card("Clubs", "Queen");
  hand_same_suits[4] = Card("Clubs", "Ace");
  assert(all_same_suit(hand_same_suits) == true);
}


