public enum Suit implements CardAttribute {
    CLUBS, SPADES, HEARTS, DIAMONDS;

    public Suit next() {
        return Suit.values()[(ordinal() + 1) % values().length];
    }

    public enum Color {
        RED, BLACK;
    }

    public boolean isRed() {
        return (this == Suit.HEARTS || this == Suit.DIAMONDS);
    }

    public boolean isBlack() {
        return (this == Suit.SPADES || this == Suit.CLUBS);
    }

    public String pretty() {
        return name().charAt(0) + name().substring(1).toLowerCase();
    }

}
