import java.util.Objects;

public class Card {
    private Suit aSuit;
    private Rank aRank;
    private boolean aIsJoker; // Not sure how to implement. Rank and Suit are ill-defined.

    /**
     *
     * @param pRank Cannot be null
     * @param pSuit
     * @pre pRank != null
     */
    public Card(Rank pRank, Suit pSuit) {
        // Objects.requireNonNull(pRank);
        // Objects.requireNonNull(pSuit);
        // This method is nice but returns a NullPointerException when it fails so...
        assert pRank != null;
        assert pSuit != null;

        aSuit = pSuit;
        aRank = pRank;
    }

    public Card(Card pCard) {
        aRank = pCard.aRank;
        aSuit = pCard.aSuit;
    }

    public Rank rank() {
        return aRank;
    }

    public Suit suit() {
        return aSuit;
    }

    public Suit.Color color() {
        if (this.isBlack()) return Suit.Color.BLACK;
        else return Suit.Color.RED;
    }

    public boolean isRed() {
        return aSuit.isRed();
    }

    public boolean isBlack() {
        return aSuit.isBlack();
    }

    public Card next() {
        Rank rank = aRank.next();
        Suit suit = this.aSuit;
        if (rank == Rank.ACE) {
            suit = suit.next();
        }
        return new Card(rank, suit);
    }

    @Override
    public String toString() {
        return aRank.pretty() + " of " + aSuit.pretty();
    }
}

