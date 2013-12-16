/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 5/12/13
 * Time: 15:11
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.format {
import be.devine.cp3.starling.billsplit.vo.IouVO;

public class PriceFormat {
    public function PriceFormat() {
    }

    public static function priceToPercentage(price:Number, totalPrice:Number):Number {
        return price / totalPrice;
    }

    public static function calculatePrices(iouVO:IouVO, ious:Array):Array {
        // Prijs berekeken via nieuwe prijs -> de rest gelijk verdelen
        return [];
    }
}
}
