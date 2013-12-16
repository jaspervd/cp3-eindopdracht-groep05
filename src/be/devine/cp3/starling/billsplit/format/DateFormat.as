/**
 * Created with IntelliJ IDEA.
 * User: Jasper
 * Date: 16/12/13
 * Time: 15:58
 * To change this template use File | Settings | File Templates.
 */
package be.devine.cp3.starling.billsplit.format {
public class DateFormat {
    public function DateFormat() {
    }

    public static function timestampToUFDate(timestamp:int):String { // UF = User Friendly
        var today:Date = new Date();
        var date:Date = new Date(timestamp);
        var timeAgo:String = "";
        var timeString:String = "am";

        switch (today.date) {
            case date.date:
                timeAgo = "today";
                break;
            case date.date - 1:
                timeAgo = "yesterday";
                break;
        }

        trace(today.date, date.date);

        if(date.getHours() > 11) {
            date.setHours(date.getHours() - 12);
            timeString = "pm";
        }

        if(date.getHours() == 0) {
            date.setHours(12);
        }

        return timeAgo + " @ " + date.getHours() + timeString; // today @ 2pm
    }
}
}
