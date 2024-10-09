public interface CardAttribute {
    /**
     * NULL OBJECT design pattern
     **/
    static CardAttribute NONE = new CardAttribute() {
        @Override
        public String pretty() {
            return "None";
        }

    };

    String pretty();

}
