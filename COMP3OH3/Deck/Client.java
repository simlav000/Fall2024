import java.util.ArrayList;

public class Client {

    public static void main(String[] args) {
        Deck d = new Deck();
        Hand h1 = new Hand(5);
        Hand h2 = new Hand(5);

        System.out.println(d.size());
        h1.add(d.draw());
        h1.add(d.draw());
        System.out.println(h1);
        System.out.println(d.size());
        h2.add(d.draw());
        System.out.println(h2);

        System.out.println(Hand.createDescendingComparator().compare(h1, h2));

    }
}
