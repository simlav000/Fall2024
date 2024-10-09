import java.util.Collections;

public class Client {

    public static void main(String[] args) {
        Deck d = new Deck(DeckModifier.NULL);
        Hand h = new Hand();
        // TODO: Make it so I can do h.add(d.draw(8));

        for (int i = 0; i < 8; i++) {
            h.add(d.draw());
        }

        h.sortBySuit();

        System.out.println(h);
    }
}
