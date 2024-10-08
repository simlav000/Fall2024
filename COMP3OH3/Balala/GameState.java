import java.util.List;

/**
 * This class implements the SINGLETON pattern to enforce that a single
 * GameState takes place during the execution of the program. There can
 * only be one game being played at any time.
 *
 * This is different from a FLYWEIGHT in the sense that we enforce a SINGLE
 * instance of the class to be instantiated, as opposed to multiple unique
 * instances.
 **/
public class GameState {
    private static final GameState INSTANCE = new GameState();
    private int aMoney;
    private Deck aDeck;
    private Hand aHand;

    /**
     * Creates the only GameState object when game begins. Initialzes Deck
     * to default 52 cards Hand with capacity 8, and money to 0.
     **/
    private GameState() {
        aMoney = 0;
        aDeck = new Deck();
        aHand = new Hand();
    }

    public void roundStart() {
        fillHand();
        System.out.println(aHand);
    }

    /**
     * Draws cards until Hand is full or until Deck is empty.
     **/
    public void fillHand() {
        for (int i = 0; i < aHand.capacity() && !aDeck.isEmpty(); i++) {
            aHand.add(aDeck.draw());
        }
    }

    public static GameState instance() {
        return INSTANCE;
    }
}
