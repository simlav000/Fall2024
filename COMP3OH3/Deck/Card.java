import java.util.Optional;

public class Card {
    private Card JOKER_RED = new Card();
    private Card JOKER_BLACK = new Card();
    private CardAttribute aSuit;
    private CardAttribute aRank;

    /**
     *
     * @param pRank Cannot be null
     * @param pSuit
     * @pre pRank != null
     */
    public Card(Rank pRank, Suit pSuit) {
        assert pRank != null;
        assert pSuit != null;

        aRank = pRank;
        aSuit = pSuit;
    }

    public Card(Card pCard) {
        aRank = pCard.aRank;
        aSuit = pCard.aSuit;
    }

    private Card() {
        aRank = CardAttribute.NONE;
        aSuit = CardAttribute.NONE;
    }

    public Rank rank() {
        return (Rank) aRank;
    }

    public Suit suit() {
        return (Suit) aSuit;
    }

    public Suit.Color color() {
        if (this.isBlack())
            return Suit.Color.BLACK;
        else
            return Suit.Color.RED;
    }

    public boolean isRed() {
        return suit().isRed();
    }

    public boolean isBlack() {
        return suit().isBlack();
    }

    public boolean isRedJoker() {
        return this == JOKER_RED;
    }

    public boolean isBlackJoker() {
        return this == JOKER_BLACK;
    }

    public boolean isJoker() {
        return isRedJoker() || isBlackJoker();
    }

    public Card next() {
        Rank rank = this.rank().next();
        Suit suit = this.suit();
        if (rank == Rank.ACE) {
            suit = suit.next();
        }
        return new Card(rank, suit);
    }

    @Override
    public String toString() {
        if (isBlackJoker())
            return "Black Joker";
        if (isRedJoker())
            return "Red Joker";

        return aRank.pretty() + " of " + aSuit.pretty();
    }
}
