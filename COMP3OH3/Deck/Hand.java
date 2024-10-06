import java.util.Iterator;
import java.util.Comparator;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;

public class Hand implements Iterable<Card>, Comparable<Hand> {
    private int aCapacity;
    private List<Card> aCards = new ArrayList<>();

    enum HandComparator {
        ASCENDING, DESCENDING, POKER;
    };

    public Hand(int pCapacity) {
        assert pCapacity > 0;
        aCapacity = pCapacity;
    }

    public List<Card> getCards() {
        return Collections.unmodifiableList(aCards);
    }

    /**
     * Add pCard to the hand.
     * 
     * @param pCard The card in question
     * @pre !isFull()
     * @pre pCard != null
     **/
    public void add(Card pCard) {
        assert pCard != null;
        assert !isFull();
        aCards.add(pCard);
    }

    /**
     * Remove a card from the hand
     *
     * @param pCard The card in question
     * @pre !isEmpty()
     * @pre pCard != null
     **/
    public void remove(Card pCard) {
        assert pCard != null;
        assert !isEmpty();
        aCards.remove(pCard);
    }

    /**
     * @return The number of cards in hand
     **/
    public int size() {
        return aCards.size();
    }

    /**
     * Verifies if a card is present in hand
     *
     * @param pCard The card in question
     * @return True if card is present else false
     * @pre pCard != null
     **/
    public boolean contains(Card pCard) {
        assert pCard != null;
        return aCards.contains(pCard);
    }

    /**
     * Verifies if hand is empty
     *
     * @return True if hand is empty else false
     **/
    public boolean isEmpty() {
        return aCards.isEmpty();
    }

    /**
     * Verifies if hand is full
     *
     * @return True if number of cards is equal
     *         to the capacity as defined by constructor
     *         else false
     **/
    public boolean isFull() {
        return aCards.size() == aCapacity;
    }

    @Override
    public String toString() {
        String output = "[ - ";
        for (Card c : aCards) {
            output += c.toString();
            output += " - ";
        }
        output += "]";
        return output;
    }

    public Iterator<Card> iterator() {
        return aCards.iterator();
    }

    @Override
    public int compareTo(Hand h) {
        if (aCards.size() > h.aCards.size())
            return 1;
        else if (aCards.size() == h.aCards.size())
            return 0;
        return -1;
    }

    public static Comparator<Hand> createAscendingComparator() {
        return new Comparator<Hand>() {

            @Override
            public int compare(Hand pHand1, Hand pHand2) {
                return pHand1.aCards.size() - pHand2.aCards.size();
            }
        };
    }

    public static Comparator<Hand> createDescendingComparator() {
        return new Comparator<Hand>() {

            @Override
            public int compare(Hand pHand1, Hand pHand2) {
                return pHand2.aCards.size() - pHand1.aCards.size();
            }
        };
    }

    /**
     * Static factory method returning a comparator for which
     * hand contains the largest number of cards having a given rank.
     *
     * @param pRank The rank in question
     * @return A new comparator instance that can compare by number of cards
     *         of desired rank
     **/
    public static Comparator<Hand> createByRankComparator(Rank pRank) {
        return new Comparator<Hand>() {

            @Override
            public int compare(Hand pHand1, Hand pHand2) {
                return countCards(pHand1, pRank) - countCards(pHand2, pRank);
            }

            private int countCards(Hand pHand, Rank pRank) {
                int total = 0;
                for (Card c : pHand) {
                    if (c.rank() == pRank)
                        total++;
                }
                return total;
            }

        };
    }

}
