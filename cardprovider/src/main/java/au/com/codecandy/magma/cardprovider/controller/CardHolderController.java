package au.com.codecandy.magma.cardprovider.controller;

import au.com.codecandy.magma.cardprovider.model.CardHolder;
import au.com.codecandy.magma.cardprovider.service.State;
import au.com.codecandy.magma.cardprovider.utility.Constants;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@RestController
public class CardHolderController {

    public CardHolderController() {
        newCardHolder("John", "Clarke", "Farnahm");
    }

    @PostMapping(value = Constants.cardholderMapping + "/new")
    public Map<String, String> newCardHolder(@RequestParam(value = "firstName") String firstName, @RequestParam(value = "lastName") String lastName, @RequestParam(value = "middleName", required = false) String middleName) {
        int id = findNextId();

        CardHolder cardholder = new CardHolder(id);

        // Set the cardholders details
        cardholder.setFirstName(firstName);
        cardholder.setLastName(lastName);
        if (middleName != null) {
            cardholder.setMiddleName(middleName);
        } else {
            cardholder.setMiddleName("");
        }

        // Add our new cardholder to our controller storage
        State.getInstance().addCardHolder(cardholder);

        // Respond to the user
        return cardholder.toObject();
    }

    private int findNextId() {
        return State.getInstance().getCardHolders().size() + 1;
    }
}
