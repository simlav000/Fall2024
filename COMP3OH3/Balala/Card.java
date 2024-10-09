import java.util.Objects;
import java.util.Optional;

public class Card {
    private static final Card JOKER_RED = new Card();
    private static final Card JOKER_BLACK = new Card();
    private final Optional<Suit> aSuit;
    private final Optional<Rank> aRank;

    /**
     * @param pRank Cannot be null
     * @param pSuit
     * @pre pRank != null
     */
    public Card(Rank pRank, Suit pSuit) {
        assert pRank != null;
        assert pSuit != null;

        aRank = Optional.of(pRank);
        aSuit = Optional.of(pSuit);
    }

    public Card(Card pCard) {
        aRank = pCard.aRank;
        aSuit = pCard.aSuit;
    }

    private Card() {
        aRank = Optional.empty();
        aSuit = Optional.empty();
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

    /**
     * TODO: What comes before/after jokers?
     **/
    public Card next() {
        Rank rank = this.rank().next();
        Suit suit = this.suit();
        if (rank == Rank.TWO) {
            suit = suit.next();
        }
        return new Card(rank, suit);
    }

    /**
     * If this is absent, doing card1.equals(card2)
     * would simply return true iff card1 and card2
     * have the same ID. That is, they are exactly
     * the same, and is just like card1 == card2
     **/
    @Override
    public boolean equals(Object pObject) {
        if (this == pObject) {
            return true; // quick optimization
        }

        if (pObject.getClass() != getClass()) {
            return false;
        }
        return aRank.get() == ((Card) pObject).rank()
                && aSuit.get() == ((Card) pObject).suit();
    }

    /**
     * Classes overriding the equals() method ought to also
     * override the hashCode() method as they are interchangably
     * used for making sets and hashmaps.
     **/
    @Override
    public int hashCode() {
        return Objects.hash(aRank, aSuit);
    }

    @Override
    public String toString() {
        if (isBlackJoker())
            return "Black Joker";
        if (isRedJoker())
            return "Red Joker";

        return aRank.get().pretty() + " of " + aSuit.get().pretty();
    }
}
