package be.devine.cp3.starling.billsplit.factory {
import be.devine.cp3.starling.billsplit.vo.IouVO;

public class IouVOFactory {
    public static function createIouVOFromObject(iou:Object):IouVO {
        var iouVO:IouVO = new IouVO();
        iouVO.id = iou.id;
        iouVO.price = iou.price;
        iouVO.person_id = iou.person_id;
        iouVO.task_id = iou.task_id;
        iouVO.paid = iou.paid;
        return iouVO;
    }
}
}