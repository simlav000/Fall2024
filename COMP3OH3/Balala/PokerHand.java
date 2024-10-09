import java.util.Map;
import java.util.HashMap;

public enum PokerHand {
    FIVEOFAKIND(120, 12), FLUSHHOUSE(140, 14), FLUSHFIVE(160, 16),
    STRAIGHTFLUSH(100, 8), FOUROFAKIND(60, 7), ROYALFLUSH(100, 8),
    FULLHOUSE(40, 4), FLUSH(35, 4), STRAIGHT(30, 4), THREEOFAKIND(30, 3),
    TWOPAIR(20, 2), PAIR(10, 2), HIGHCARD(5, 1);

    private int aChips;
    private int aMult;
    private int aNumTimesPlayed = 0;

    PokerHand(int pChips, int pMult) {
        aChips = pChips;
        aMult = pMult;
    }

    public int playPokerHand() {
        aNumTimesPlayed++;
        return (int) (aChips * aMult); // Adjust score by multiplier
    }

    public int getTimesPlayed() {
        return aNumTimesPlayed;
    }

    public void improveChips(int pChips) {
        aChips += pChips;
    }

    public void improveMult(double pMult) {
        aMult += pMult;
    }

    public int getChips() {
        return aChips;
    }

    public double getMult() {
        return aMult;
    }

    public PokerHand getPokerHand(Hand pHand) {
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

            else if (count == 2) {
                return PAIR;
            }

        }

        return HIGHCARD;
    }

}
