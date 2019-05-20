package au.com.codecandy.magma.cardprovider.service;

import au.com.codecandy.magma.cardprovider.model.CardHolder;

import java.util.Vector;

public class State {
    private static State instance = new State();
    private Vector<CardHolder> cardHolders;

    public static State getInstance() {
        return instance;
    }

    private State() {
        cardHolders = new Vector<>();
    }

    public Vector<CardHolder> getCardHolders() {
        return cardHolders;
    }

    public CardHolder getCardHolderById(int id) {
        CardHolder cardHolder;

        for (int i = 0; i < cardHolders.size(); i++) {
            if (cardHolders.get(i).getId() == id) {
                return cardHolders.get(i);
            }
        }

        return null;
    }

    public void addCardHolder(CardHolder cardHolder) {
        cardHolders.add(cardHolder);
    }
}
