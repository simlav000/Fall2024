import java.util.Optional;

public class Card {
    private Optional<Suit> aSuit;
    private Optional<Rank> aRank;

    /**
     *
     * @param pRank Cannot be null
     * @param pSuit
     * @pre pRank != null
     */
    public Card(Rank pRank, Suit pSuit) {
        assert pRank != null;
        assert pSuit != null;

        aSuit = Optional.of(pSuit);
        aRank = Optional.of(pRank);
    }

    public Card(Card pCard) {
        aRank = pCard.aRank;
        aSuit = pCard.aSuit;
    }

    public Rank rank() {
        return aRank.get();
    }

    public Suit suit() {
        return aSuit.get();
    }

    public Suit.Color color() {
        if (this.isBlack())
            return Suit.Color.BLACK;
        else
            return Suit.Color.RED;
    }

    public boolean isRed() {
        return aSuit.get().isRed();
    }

    public boolean isBlack() {
        return aSuit.get().isBlack();
    }

    public Card next() {
        Rank rank = aRank.get().next();
        Suit suit = this.aSuit.get();
        if (rank == Rank.ACE) {
            suit = suit.next();
        }
        return new Card(rank, suit);
    }

    @Override
    public String toString() {
        return aRank.get().pretty() + " of " + aSuit.get().pretty();
    }
}
