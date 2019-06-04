package au.com.codecandy.magma.cardprovider.controller;

import au.com.codecandy.magma.cardprovider.model.Card;
import au.com.codecandy.magma.cardprovider.model.CardHolder;
import au.com.codecandy.magma.cardprovider.service.State;
import au.com.codecandy.magma.cardprovider.utility.Constants;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

@RestController
public class CardController {
    /** New Card Creation **/
    @PostMapping(value = Constants.cardMapping + "/new")
    public Map<String, Object> newCard(@RequestParam("cardholderID") int cardholderID) {
        CardHolder cardHolder = State.getInstance().getCardHolderById(cardholderID);
        if (cardHolder != null) {
            Card card = generateNewCard(cardHolder);
            cardHolder.addCard(card);
            return card.toObject();
        }

        Map<String, Object> map = new HashMap<>();
        map.put("Error", "User not found");

        return map;
    }

    private Card generateNewCard(CardHolder cardHolder) {
        return new Card(cardHolder);
    }

    /** Card Retrieval */
    @GetMapping(value = Constants.cardMapping)
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
    }
}
