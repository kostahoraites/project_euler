#=
Poker hands
Problem 54

In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:

    High Card: Highest value card.
    One Pair: Two cards of the same value.
    Two Pairs: Two different pairs.
    Three of a Kind: Three cards of the same value.
    Straight: All cards are consecutive values.
    Flush: All cards of the same suit.
    Full House: Three of a kind and a pair.
    Four of a Kind: Four cards of the same value.
    Straight Flush: All cards are consecutive values of same suit.
    Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

The cards are valued in the order:
2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.

Consider the following five hands dealt to two players:
Hand	 	Player 1	 	Player 2	 	Winner
1	 	5H 5C 6S 7S KD
Pair of Fives
	 	2C 3S 8S 8D TD
Pair of Eights
	 	Player 2
2	 	5D 8C 9S JS AC
Highest card Ace
	 	2C 5C 7D 8S QH
Highest card Queen
	 	Player 1
3	 	2D 9C AS AH AC
Three Aces
	 	3D 6D 7D TD QD
Flush with Diamonds
	 	Player 2
4	 	4D 6S 9H QH QC
Pair of Queens
Highest card Nine
	 	3D 6D 7H QD QS
Pair of Queens
Highest card Seven
	 	Player 1
5	 	2H 2D 4C 4D 4S
Full House
With Three Fours
	 	3C 3D 3S 9S 9D
Full House
with Three Threes
	 	Player 1

The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.

How many hands does Player 1 win?

=#


# READ DATA


function parse_numbers(s)
    pieces = split(s, ' ', keepempty=false)
    return pieces
end


cards = []

open("data/p054_poker.txt") do f
    for (i, line) in enumerate(eachline(f))
        push!(cards, parse_numbers(line))
    end
end

# cards is a 2D array, where cards[i][j] specifies the jth element of the ith row (1, 2, 3, ...)

#= example
julia> cards[1]
10-element Array{SubString{String},1}:
 "8C"
 "TS"
 "KC"
 "9H"
 "4S"
 "7D"
 "2S"
 "5D"
 "3S"
 "AC"
=#

#cards=1000 hands
#hands = 10 cards (hand 1 and hand 2)
#hand = 5 cards
#card = a string with 2 characters "KH" = King of hearts
#value = numeric value 2-14, integer
#suit = character 'S' spade, 'C', 'H', 'D'


using Multisets

function value(card)
 v = card[1]
 if v=='T'
  return 10
 end
 if v=='J'
  return 11
 end
 if v=='Q'
  return 12
 end
 if v=='K'
  return 13
 end
 if v=='A'
  return 14
 end
 # else
 return  parse(Int, v)
end

function suit(card)
 return card[2]
end


function cardvalues(hand)
 return map(value, hand)
end

function cardsuits(hand)
 return map(suit, hand)
end


function handvalue(hand)
 # MAIN FUNCTION, 
 #evaluate hand value (0=high card, 1=one-pair, 2=two-pair, 3=three-of-a-kind,
 #                      4=straight, 5=flush, 6=full house, 7=four-of-a-kind,
 #                      8=straight flush, 9=royal flush)
 # use multi-sets to check if all cards are different values
 ms = Multiset(cardvalues(hand))
 mult = collect(values(ms))  # multiplicities
 k = collect(keys(ms))  # numeric values
 if length(mult) == 2   # the hand is only made of two card values
  k = collect(keys(ms))
  mult = collect(values(ms))  # multiplicities
  if maximum(mult) == 4
   return 7  # four-of-a-kind
  else
   return 6  # full house
  end
 end
 if length(mult) == 3   # the hand is only made of three card values
  if maximum(mult) == 2
   return 2 # two-pair
  else
   return 3 # three-of-a-kind
  end
 end
 if length(mult) == 4   # the hand is only made of four card values
  return 1   # one-pair
 end
 if length(mult) == 5   # the hand is only made of two card values
  ms_suit = Multiset(cardsuits(hand))
  mult_suit = collect(values(ms_suit))  # multiplicities
  isstraight = (maximum(k) == minimum(k)+4)   # boolean
  isflush = (length(mult_suit) == 1)          # boolean
  if isstraight & isflush
   if maximum(k) == 14
    return 9  # ace is the high card, royal flush
   else
    return 8  # straight flush
   end
  else
   if isstraight
    return 4
   end
   if isflush
    return 5
   end
    #else
   return 0    # high card
  end
 end
end


function sort_tiebreakers(hand)
 ms = Multiset(cardvalues(hand))
 mult = collect(values(ms))  # multiplicities
 k = collect(keys(ms))       # numeric values
 hs = [] # sorted hand
 hs_val = []  # weights to use for sorting
 for i=1:length(k)
  append!(hs, zeros(Int, mult[i]) .+ k[i])
  append!(hs_val,  zeros(Int, mult[i]) .+ (k[i] * 100^(mult[i])))
 end
 println(hs)
 println(hs_val)
 j = Array(1:length(hs_val))
 j = reverse(sort(j, by=x->hs_val[x]))
 return hs[j]
end


function break_tie(hand1, hand2)
 #if two hands have the same value(0-9), break the tie by comparing high cards
 c1 = sort_tiebreakers(hand1)   # sort so the highest value cards appear first
 c2 = sort_tiebreakers(hand2)   # sort so the highest value cards appear first
 for i=1:5
  if c1[i] > c2[i]
   println("Player 1 wins!", c1, c2)
   return 1   # player 1 wins
  end
  if c1[i] < c2[i]
   println("Player 2 wins!", c1, c2)
   return 0   # player 2 wins
  end
 end
end


function p1_win(hands)
 # hands is a 10-card string 
 hand1 = hands[1:5]
 hand2 = hands[6:10]
 if handvalue(hand1) > handvalue(hand2)
  println("Player 1 wins!", hand1, hand2)
  return 1
 end
 if handvalue(hand1) < handvalue(hand2)
  println("Player 2 wins!", hand1, hand2)
  return 0
 end
 if handvalue(hand1) == handvalue(hand2)
  return break_tie(hand1, hand2)
 end
end

answer = mapfoldl(p1_win, +, cards; init=0)     #for each hand in the string array of all hands,
                                         #evaluate who won and add +1 if p1 won. 

println("Player 1 won $answer hands")






