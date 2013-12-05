/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 5/12/13
 * Time: 13:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.vo {

public class TaskVO {
    public var id:uint;
    public var title:String;
    public var type:String;
    public var price:Number;
    public var price_id:uint;
    public var timestamp:String;
    public var paid:Boolean = false;

    public function TaskVO(value:Object){

         id = value.id;
         title = value.title;
         type = value.type;
         price = value.price;
         price_id = value.price_id;
         timestamp = value.timestamp;
         paid = value.paid;

    }
}
}