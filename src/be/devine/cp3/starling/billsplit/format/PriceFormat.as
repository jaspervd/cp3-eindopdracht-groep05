package be.devine.cp3.starling.billsplit.format {

public class PriceFormat {
    public function PriceFormat() {
    }

    public static function priceToPercentage(price:Number, totalPrice:Number):Number {
        return Number((price / totalPrice).toFixed(2)) * 100;
    }

    public static function percentageToPrice(percentage:Number, totalPrice:Number):uint {
        return Number(((totalPrice / 100) * percentage).toFixed(2));
    }

    public static function calculatePricesEvenly(total:Number, persons:Array):Number {
        return total / persons.length;
    }
}
}
