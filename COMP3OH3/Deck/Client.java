import java.util.ArrayList;

public class Client {

    public static void main(String[] args) {
        for (Card c : new Deck()) {
            if (! c.isJoker() ) {
                System.out.println(c.rank().pretty());
            }

    }
}
