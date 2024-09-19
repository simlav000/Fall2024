import java.util.ArrayList;

public class Client {

    public static void main(String[] args) {
        Card c1 = new Card(Rank.JAMES, Suit.SPADES);
        Card c2 = new Card(Rank.ACE, Suit.HEARTS);
        Card c3 = new Card(Rank.TWO, Suit.HEARTS);
        Hand h1 = new Hand(5);
        Hand h2 = new Hand(5);

        h2.add(c2);
        h1.add(null);

        System.out.println(h1.compareTo(h2));

    }
}
