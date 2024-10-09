import java.util.function.Predicate;

public class DeckModifier implements Predicate<Card> {
    enum Modifier {
        ALL_CARDS, NO_ACES, RED_ONLY;
    }

    // Singleton instance for no modification
    public static final DeckModifier NULL = new DeckModifier(Modifier.ALL_CARDS) {
        @Override
        public boolean test(Card pCard) {
            return true; // Always returns true, no filtering
        }
    };

    public final Modifier aModifier;

    public DeckModifier(Modifier pModifier) {
        aModifier = pModifier;
    }

    @Override
    public boolean test(Card pCard) {

        return (aModifier == Modifier.NO_ACES && pCard.rank() == Rank.ACE ||
                aModifier == Modifier.RED_ONLY && pCard.isBlack());

    }
}
