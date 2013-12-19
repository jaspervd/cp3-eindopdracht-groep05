/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 5/12/13
 * Time: 15:11
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.format {

public class PriceFormat {
    public function PriceFormat() {
    }

    public static function priceToPercentage(price:Number, totalPrice:Number):Number {
        return price / totalPrice;
    }

    public static function calculatePrices(total:Number, persons:Array):Number {
        // Prijs berekeken via nieuwe prijs -> de rest gelijk verdelen
        trace(persons.length);
        return total/persons.length;
    }
}
}
