import java.util.function.Predicate;

public class DeckModifier implements Predicate<Card> {
    enum Modifier {
        ALL_CARDS, NO_ACES, RED_ONLY;
    }

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

