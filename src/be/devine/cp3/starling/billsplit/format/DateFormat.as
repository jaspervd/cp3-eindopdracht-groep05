package be.devine.cp3.starling.billsplit.format {

public class DateFormat {
    public function DateFormat() {
    }

    public static function timestampToUFDate(timestamp:Number):String { // UF = User Friendly
        var today:Date = new Date();
        var date:Date = new Date(timestamp);
        var timeAgo:String = "";
        var timeString:String = "am";

        if (today.date < (date.date + 7)) { // if not longer than 7 days ago
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
        } else {
            timeAgo = date.date + " " + getMonthAbbr(date.month) + " " + date.fullYear;
        }

        if (date.hours > 11) {
            date.setHours(date.hours - 12);
            timeString = "pm";
        }

        if (date.hours == 0) {
            date.setHours(12);
        }

        return timeAgo + " @ " + date.hours + timeString; // today @ 2pm
    }

    private static function getMonthAbbr(month:Number):String {
        switch (month) {
            case 0:
                return "Jan";
                break;
            case 1:
                return "Feb";
                break;
            case 2:
                return "Mar";
                break;
            case 3:
                return "Apr";
                break;
            case 4:
                return "May";
                break;
            case 5:
                return "June";
                break;
            case 6:
                return "July";
                break;
            case 7:
                return "Aug";
                break;
            case 8:
                return "Sep";
                break;
            case 9:
                return "Oct";
                break;
            case 10:
                return "Nov";
                break;
            case 11:
                return "Dec";
                break;
            default:
                return "";
                break;
        }
    }
}
}
