package au.com.codecandy.magma.cardprovider.controller;

import au.com.codecandy.magma.cardprovider.model.Card;
import au.com.codecandy.magma.cardprovider.model.CardHolder;
import au.com.codecandy.magma.cardprovider.service.State;
import au.com.codecandy.magma.cardprovider.utility.Constants;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;

@RestController
public class CardController {
    @PostMapping(value = Constants.cardMapping + "/new")
    public Map<String, Object> newCard(@RequestParam("cardholderID") int cardholderID) {
        Card card = generateNewCard(cardholderID);

        if (card != null) {
            return card.toObject();
        } else {
            Map <String, Object> map = new HashMap<>();
            map.put("Error", "User not found");

            return map;
        }
    }

    private Card generateNewCard(int cardholderID) {
        CardHolder cardHolder = State.getInstance().getCardHolderById(cardholderID);
        if (cardHolder != null) {
            return new Card(cardHolder);
        }

        return null;
    }
}
