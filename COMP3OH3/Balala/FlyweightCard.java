import java.util.Optional;

/**
 * The following is an implementation which ensures that all cards in the deck
 * are unique. That is, if a user creates an Ace of Spades, then tries to
 * create another, the second action simply yields the first (and only)
 * instance. Ensures no cheating!
 **/
public class FlyweightCard {
    private final Optional<Rank> aRank;
    private final Optional<Suit> aSuit;
    private static final FlyweightCard[][] CARDS = // Stores unique instances
            new FlyweightCard[Suit.values().length][Rank.values().length];
    /**
     * Since there are only 52 cards, initializing all instances
     * is acceptable. Otherwise, in the static get() method, we
     * could check to see if it exists. If so, return it, otherwise,
     * create it and return it.
     **/
    static {
        for (Suit suit : Suit.values()) {
            for (Rank rank : Rank.values()) {
                CARDS[suit.ordinal()][rank.ordinal()] = new FlyweightCard(rank, suit);
            }
        }
    }

    private FlyweightCard(Rank pRank, Suit pSuit) {
        aRank = Optional.of(pRank);
        aSuit = Optional.of(pSuit);

    }

    public static FlyweightCard get(Rank pRank, Suit pSuit) {
        return CARDS[pSuit.ordinal()][pRank.ordinal()];
    }

    public Rank rank() {
        return aRank.get();
    }

    public Suit suit() {
        return aSuit.get();
    }

}
