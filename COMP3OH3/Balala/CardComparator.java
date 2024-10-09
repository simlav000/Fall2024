import java.util.Comparator;

public class CardComparator implements Comparator<Card> {
    public enum Order {
        SUIT, RANK;
    }

    private Order aOrder = Order.SUIT;

    /**
     * Default constructor which compares by ascending order
     **/
    public CardComparator() {
    };

    /**
     * Comparator constructor which compares according to specified order
     **/
    public CardComparator(Order pOrder) {
        assert pOrder != null;
        aOrder = pOrder;
    };

    /**
     * @param pOrder The comparison order.
     * @pre pOrder != null
     **/
    public void setOrder(Order pOrder) {
        assert pOrder != null;
        aOrder = pOrder;
    }

    @Override
    public int compare(Card pCard1, Card pCard2) {
        if (aOrder == Order.SUIT) {
            int suitComparison = pCard1.suit().compareTo(pCard2.suit());
            if (suitComparison == 0) {
                return -pCard1.rank().compareTo(pCard2.rank());
            }
            return suitComparison;
        } else {
            int rankComparison = -pCard1.rank().compareTo(pCard2.rank());
            if (rankComparison == 0) {
                return pCard1.suit().compareTo(pCard2.suit());
            }
            return rankComparison;

        }
    }
}
