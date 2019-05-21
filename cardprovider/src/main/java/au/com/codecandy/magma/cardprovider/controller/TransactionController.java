package au.com.codecandy.magma.cardprovider.controller;

import au.com.codecandy.magma.cardprovider.model.Card;
import au.com.codecandy.magma.cardprovider.model.CardHolder;
import au.com.codecandy.magma.cardprovider.model.Transaction;
import au.com.codecandy.magma.cardprovider.service.State;
import au.com.codecandy.magma.cardprovider.utility.Constants;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.Currency;
import java.util.HashMap;
import java.util.Map;

@RestController
public class TransactionController {
    /** New Card Creation **/
    @PostMapping(value = Constants.transactionMapping + "/new")
    public Map<String, Object> newTransaction(@RequestParam("cardNo") String cardNo, @RequestParam("cardholderID") int cardholderID, @RequestParam("amount") double amount, @RequestParam("receiver") String receiver, @RequestParam("currency") String currency, @RequestParam("location") String location) {
        CardHolder cardHolder = State.getInstance().getCardHolderById(cardholderID);
        if (cardHolder != null) {
            Card card = cardHolder.getCard(cardNo);

            if (card != null) {
                Transaction transaction = new Transaction();
                transaction.setCard(card);
                transaction.setAmount(amount);
                transaction.setReceiver(receiver);
                transaction.setCurrency(Currency.getInstance(currency));
                transaction.setDate();
                transaction.setLocation(location);
                card.addTransaction(transaction);

                Map<String, Object> map = new HashMap<>();
                map.put("transaction", transaction.toObject());

                return map;
            } else {
                Map<String, Object> map = new HashMap<>();
                map.put("Error", "Card not found");

                return map;
            }
        }

        Map<String, Object> map = new HashMap<>();
        map.put("Error", "User not found");

        return map;
    }

    /** Card Retrieval */
    /*@GetMapping(value = Constants.transactionMapping)
    public Map<String, Object> getCards(@RequestParam("cardholderID") int cardholderID) {
        Logger logger = Logger.getLogger(CardController.class.getName());

        logger.log(Level.INFO, "Got Here");

        // Get our cardholder
        CardHolder cardHolder = State.getInstance().getCardHolderById(cardholderID);
        if (cardHolder != null) {
            // Return our vector of cards that belong to the user
            Vector<Card> cards = cardHolder.getCards();
            Vector<Map<String, Object>> cardsSerialised = new Vector<>();

            for (int i = 0; i < cards.size(); i++) {
                cardsSerialised.add(cards.get(i).toObject());
            }

            Map <String, Object> map = new HashMap<>();
            map.put("cardholder", cardholderID);
            map.put("cards", cardsSerialised);

            return map;
        } else {
            Map <String, Object> map = new HashMap<>();
            map.put("Error", "User not found");

            return map;
        }
    }*/
}



