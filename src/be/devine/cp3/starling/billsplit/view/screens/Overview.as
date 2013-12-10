/**
 * Created with IntelliJ IDEA.
 * User: test
 * Date: 9/12/13
 * Time: 13:41
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.view.screens {
import be.devine.cp3.starling.billsplit.model.PersonModel;
import be.devine.cp3.starling.billsplit.vo.PersonVO;

import feathers.controls.Screen;

public class Overview extends Screen {
    private var _personModel:PersonModel;
    private var _moderator:PersonVO;

    public function Overview() {
        _personModel = PersonModel.getInstance();

        _moderator = _personModel.getModerator();

        trace('[Overview]', _moderator);
    }
}
}
