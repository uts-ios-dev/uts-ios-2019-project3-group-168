package au.com.codecandy.magma.cardprovider.model;

import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

public class CardHolder {
    private int id;
    private String firstName;
    private String lastName;
    private String middleName;
    private String address;
    private String address2;
    private String city;
    private String state;
    private String postal_code;
    private String country;
    private String phone;
    private Vector<Card> cards = new Vector<>();

    public CardHolder(int id) {
        this.id = id;
    }

    /** Getters **/
    public int getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public String getName() {
        return firstName + " " + middleName + " " + lastName;
    }

    public Card getCard(String cardNo) {
        for (int i = 0; i < cards.size(); i++) {
            if (cards.get(i).getNumber().equals(cardNo)) {
                return cards.get(i);
            }
        }

        return null;
    }

    public Vector<Card> getCards() {
        return cards;
    }

    /** Setters **/
    public void setFirstName(String name) {
        this.firstName = name;
    }

    public void setLastName(String name) {
        this.lastName = name;
    }

    public void setMiddleName(String name) {
        this.middleName = name;
    }

    // Add a card to our cardholder
    public void addCard(Card card) {
        this.cards.add(card);
    }

    // Returns the cardholder as a response object
    public Map<String, String> toObject() {
        HashMap<String, String> map = new HashMap<>();
        map.put("id", id + "");
        map.put("firstName", firstName);
        map.put("middleName", middleName);
        map.put("lastName", lastName);

        return map;
    }
}
