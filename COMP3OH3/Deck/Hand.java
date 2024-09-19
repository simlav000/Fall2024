import java.util.Collections;
import java.util.List;
import java.util.ArrayList;

public class Hand implements Comparable<Hand> {
    private int aCapacity;
    private List<Card> aCards = new ArrayList<>();

    public Hand(int pCapacity) {
        aCapacity = pCapacity;
    }

    public List<Card> getCards() {
        return Collections.unmodifiableList(aCards);
    }

    public void add(Card pCard) {
        assert pCard != null;
        assert aCards.size() + 1 <= aCapacity;
        aCards.add(pCard);
    }

    public void remove(Card pCard) {
        assert pCard != null;
        assert !aCards.isEmpty();
        aCards.remove(pCard);
    }

    public int size() {
        return aCards.size();
    }

    public boolean contains(Card pCard) {
        assert pCard != null;
        return aCards.contains(pCard);
    }

    public boolean isEmpty() {
        return aCards.isEmpty();
    }

    public boolean isFull() {
        return aCards.size() == aCapacity;
    }

    @Override
    public int compareTo(Hand h) {
        if (aCards.size() > h.aCards.size())
            return 1;
        else if (aCards.size() == h.aCards.size())
            return 0;
        return -1;
    }

}
