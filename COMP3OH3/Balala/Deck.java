import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.function.Predicate;

public class Deck implements Iterable<Card> {
    private final List<Card> aCards = new ArrayList<>();
    // final on mutable object: This enforces that aCards can only ever point
    // to this ArrayList and nothing else. It does not mean that aCards cannot
    // be modified in some way, such as drawing cards.

    public Deck(Predicate<Card> pModifier) {
        initializeAllCards();
        aCards.removeIf(pModifier.negate());
        shuffle();
    }

    private void initializeAllCards() {
        for (Suit suit : Suit.values()) {
            for (Rank rank : Rank.values()) {
                aCards.add(new Card(rank, suit));
            }
        }
    }

    public Deck() {
        initializeAllCards();
        this.shuffle();
    }

    public Deck(Deck pDeck) {
        for (Card c : pDeck) {
            aCards.add(new Card(c));
        }
    }

    public List<Card> cards() {
        return new ArrayList<>(aCards);
    }

    public int size() {
        return aCards.size();
    }

    public boolean isEmpty() {
        return aCards.isEmpty();
    }

    /**
     * Draws the top card from the deck,
     * removing it from the deck in the process.
     * 
     * @return Card drawn from the deck
     * @pre Deck is not empty
     **/
    public Card draw() {
        assert !isEmpty();
        Card c = aCards.get(0);
        aCards.remove(c);
        return c;
    }

    public void shuffle() {
        Collections.shuffle(aCards);
    }

    @Override
    public String toString() {
        return aCards.toString().replace(", ", "\n");
    }

    @Override
    public Iterator<Card> iterator() {
        return new DeckIterator();
    }

    private class DeckIterator implements Iterator<Card> {
        private int aCurrentIndex;

        @Override
        public boolean hasNext() {
            return aCurrentIndex < aCards.size();
        }

        @Override
        public Card next() {
            return aCards.get(aCurrentIndex++);
        }
    }
}
