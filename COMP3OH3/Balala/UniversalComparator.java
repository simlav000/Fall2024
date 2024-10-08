import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

public class UniversalComparator implements Comparator<Hand> {
    public enum Order {
        ASCENDING, DESCENDING, POKER;
    }

    private Order aOrder = Order.ASCENDING;

    /**
     * Default constructor which compares by ascending order
     **/
    public UniversalComparator() {
    };

    /**
     * Comparator constructor which compares according to specified order
     **/
    public UniversalComparator(Order pOrder) {
        aOrder = pOrder;
    };

    public int compare(Hand pHand1, Hand pHand2) {
        switch (aOrder) {

            case DESCENDING:
                return pHand2.size() - pHand1.size();

            case POKER:
                // TODO: Figure this one out
                return 1;

            default:
                return pHand1.size() - pHand2.size();
        }

    }

    /**
     * @param pOrder The comparison order.
     * @pre pOrder != null
     **/
    public void setOrder(Order pOrder) {
        aOrder = pOrder;
    }

    // private int pokerComparator(Hand pHand) {
    // HashMap<String, Integer> hierarchy = new HashMap<>();
    // hierarchy.put("Five of a kind", 1);
    // hierarchy.put("Straight flush", 2);
    // hierarchy.put("Four of a kind", 3);
    // hierarchy.put("Full house", 4);
    // hierarchy.put("Flush", 5);
    // hierarchy.put("Straight", 6);
    // hierarchy.put("Three of a kind", 7);
    // hierarchy.put("Two pair", 8);
    // hierarchy.put("One pair", 9);
    // hierarchy.put("High card", 10);
    //
    // HashMap<Rank, Integer> rankCount = new HashMap<>();
    // for (Card c : pHand) {
    // Rank rank = c.rank();
    // rankCount.put(rank, rankCount.getOrDefault(rank, 0) + 1);
    // }
    //
    // for (Map.Entry<Rank, Integer> entry : rankCount.entrySet()) {
    // Rank rank = entry.getKey();
    // Integer count = entry.getValue();
    //
    // if (count == 5) {
    // return hierarchy.get("Five of a kind");
    // }
    //
    // else if (count == 3) {
    // return hierarchy.get("Three of a kind");
    // }
    //
    // }

}
