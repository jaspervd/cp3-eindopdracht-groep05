/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 11/12/13
 * Time: 13:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.factory {
import be.devine.cp3.starling.billsplit.vo.PersonVO;

public class PersonVOFactory {
    public static function createPersonVOFromObject(person:Object):PersonVO {
        var personVO:PersonVO = new PersonVO();
        personVO.id = person.id;
        personVO.name = person.name;
        personVO.image = person.image;
        personVO.task_id = person.task_id;
        personVO.moderator = person.moderator;
        personVO.iou = person.iou;
        return personVO;
    }
}
}
