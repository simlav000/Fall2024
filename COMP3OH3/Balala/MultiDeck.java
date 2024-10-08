import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class MultiDeck implements Iterable<Deck> {
    private List<Deck> aDecks;

    public MultiDeck() {
        aDecks = new ArrayList<Deck>();
    }

    public MultiDeck(MultiDeck pMultiDeck) {
        for (Deck d : pMultiDeck) {
            aDecks.add(new Deck(d));
        }
    }

    public void addDeck(Deck pDeck) {
        aDecks.add(pDeck);
    }

    @Override
    public Iterator<Deck> iterator() {
        return new DeckIterator();
    }

    private class DeckIterator implements Iterator<Deck> {
        private int aCurrentIndex;

        @Override
        public boolean hasNext() {
            return aCurrentIndex < aDecks.size();
        }

        @Override
        public Deck next() {
            return aDecks.get(aCurrentIndex++);
        }
    }
}

