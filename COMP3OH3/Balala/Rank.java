public enum Rank implements CardAttribute {
    TWO, THREE, FOUR, FIVE, SIX, SEVEN,
    EIGHT, NINE, TEN, JAMES, QUEEN, KING, ACE;

    public Rank next() {
        return Rank.values()[(ordinal() + 1) % values().length];
    }

    public String pretty() {
        return name().charAt(0) + name().substring(1).toLowerCase();
    }
}
