import java.util.ArrayList;

public class Client {

    public static void main(String[] args) {
        //System.out.println(new Deck());
        Card c1 = new Card(Rank.KING, Suit.DIAMONDS);
        Card c2 = c1.next();
        System.out.println(c1);
        System.out.println(c2);
    }
}

