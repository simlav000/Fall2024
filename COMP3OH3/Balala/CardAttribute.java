public interface CardAttribute {
    static CardAttribute NONE = new CardAttribute() {
        @Override
        public String pretty() {
            return "None";
        }

    };

    String pretty();

}
