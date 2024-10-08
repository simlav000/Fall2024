import java.util.Map;
import java.util.HashMap;

public enum PokerHand {
    FIVEOFAKIND, STRAIGHTFLUSH, FOUROFAKIND, FULLHOUSE, FLUSH, STRAIGHT,
    THREEOFAKIND, TWOPAIR, ONEPAIR, HIGHCARD;

    public PokerHand categorize(Hand pHand) {
        HashMap<Rank, Integer> rankCount = new HashMap<>();
        for (Card c : pHand) {
            Rank rank = c.rank();
            rankCount.put(rank, rankCount.getOrDefault(rank, 0) + 1);
        }

        for (Map.Entry<Rank, Integer> entry : rankCount.entrySet()) {
            Rank rank = entry.getKey();
            Integer count = entry.getValue();

            if (count == 5) {
                return FIVEOFAKIND;
            }

            else if (count == 4) {
                return FOUROFAKIND;
            }

            else if (count == 3) {
                return THREEOFAKIND;
            }

        }

        return HIGHCARD;
    }
}
