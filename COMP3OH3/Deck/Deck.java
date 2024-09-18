import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.function.Predicate;

public class Deck implements Iterable<Card> {
    private List<Card> aCards = new ArrayList<>();

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
        shuffle();
    }

    public Deck(Deck pDeck) {
        for (Card c : pDeck) {
            aCards.add(new Card(c));
        }
    }


    public List<Card> cards() {
        return new ArrayList<>(aCards);
    }

    public boolean isEmpty(){
        return aCards.isEmpty();
    }

    /**
     * @return
     * @pre Deck is not empty
     */
    public Card draw() {
        assert !isEmpty();
        return aCards.get(0);
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
