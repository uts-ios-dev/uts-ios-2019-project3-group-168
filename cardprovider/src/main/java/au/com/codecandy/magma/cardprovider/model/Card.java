package au.com.codecandy.magma.cardprovider.model;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class Card {
    private String number;
    private String cvc;
    private Boolean status;
    private CardHolder cardHolder;
    private Vector<Transaction> transactions = new Vector<>();

    public Card(CardHolder cardHolder) {
        number = generateRandomCardNo();
        cvc = generateRandomCVC();
        status = true;
        this.cardHolder = cardHolder;
    }

    public String getNumber() {
        return number;
    }

    public Vector<Transaction> getTransactions() {
        return transactions;
    }

    // Add a transaction to our cardholder
    public void addTransaction(Transaction transaction) {
        this.transactions.add(transaction);
    }

    // Returns the card as a response object
    public Map<String, Object> toObject() {
        HashMap<String, Object> map = new HashMap<>();
        map.put("number", number);
        map.put("cvc", cvc);
        map.put("status", status);
        map.put("cardholder", cardHolder.toObject());

        return map;
    }

    // Generate random card number
    private String generateRandomCardNo() {
        long max = 9999999999999999L;
        long min = 1000000000000000L;
        long randomCardNo = (long)(Math.random() * ((max - min) + 1) + min);
        DecimalFormat decimalFormat = new DecimalFormat("#");
        return decimalFormat.format(randomCardNo);
    }

    // Generate random cvc number
    private String generateRandomCVC() {
        int max = 999;
        int min = 100;
        double randomCvc = (Math.random() * ((max - min) + 1) + min);
        DecimalFormat decimalFormat = new DecimalFormat("#");
        return decimalFormat.format(randomCvc);
    }
}
