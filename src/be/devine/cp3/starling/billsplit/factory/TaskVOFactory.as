/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 11/12/13
 * Time: 13:12
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.factory {
import be.devine.cp3.starling.billsplit.vo.TaskVO;

public class TaskVOFactory {
    public static function createTaskVOFromObject(task:Object):TaskVO {
        var taskVO:TaskVO = new TaskVO();
        taskVO.id = task.id;
        taskVO.title = task.title;
        taskVO.type = task.type;
        taskVO.price = task.price;
        taskVO.timestamp = task.timestamp;
        taskVO.paid = task.paid;
        return taskVO;
    }
}
}
