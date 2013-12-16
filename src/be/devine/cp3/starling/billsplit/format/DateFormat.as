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

    public static function timestampToUFDate(timestamp:Number):String { // UF = User Friendly
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
            default:
                timeAgo = (today.date - date.date) + " days ago";
                break;
        }

        if(date.hours > 11) {
            date.setHours(date.hours - 12);
            timeString = "pm";
        }

        if(date.hours == 0) {
            date.setHours(12);
        }

        return timeAgo + " @ " + date.hours + timeString; // today @ 2pm
    }
}
}
