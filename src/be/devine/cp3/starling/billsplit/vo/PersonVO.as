package be.devine.cp3.starling.billsplit.vo {

public class PersonVO {

    public var id:uint;
    public var name:String;
    public var image:String;
    public var task_id:uint;
    public var moderator:Boolean;

    public function PersonVO(value:Object){


        id = value.id;
        name = value.name;
        image = value.image;
        task_id = value.task_id;
        moderator = value.moderator;

    }
}
}