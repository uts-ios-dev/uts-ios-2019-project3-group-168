package au.com.codecandy.magma.cardprovider.model;

import java.util.Currency;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Transaction {
    private Card card;
    private Double amount;
    private Currency currency;
    private String location;
    private int date;
    private String receiver;

    /** Getters **/
    public Card getCard() {
        return card;
    }

    public Double getAmount() {
        return amount;
    }

    public Currency getCurrency() {
        return currency;
    }

    public String getLocation() {
        return location;
    }

    public int getDate() {
        return date;
    }

    public String getReceiver() {
        return receiver;
    }

    /** Setters **/
    public void setCard(Card card) {
        this.card = card;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setDate() {
        this.date = new Date().getDate();
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    // Returns the transaction as a response object
    public Map<String, Object> toObject() {
        HashMap<String, Object> map = new HashMap<>();
        map.put("card", card.toObject());
        map.put("amount", amount);
        map.put("currency", currency);
        map.put("location", location);
        map.put("date", date);
        map.put("receiver", receiver);

        return map;
    }
}
