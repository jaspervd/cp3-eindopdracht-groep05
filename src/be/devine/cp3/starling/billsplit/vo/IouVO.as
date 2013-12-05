/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 5/12/13
 * Time: 13:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.vo {

public class IouVO {

    public var id:uint;
    public var price:Number;
    public var person_id:uint;
    public var task_id:uint;
    public var paid:Boolean;

    public function IouVO(value:Object){

        id = value.id;
        price = value.price;
        person_id = value.id;
        task_id = value.id;
        paid = value.paid;

    }
}
}