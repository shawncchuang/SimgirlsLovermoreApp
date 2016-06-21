/**
 * Created by shawnhuang on 2016-06-15.
 */
package model {
import com.gamua.flox.Entity;

public class PayoutList extends Entity {
    public var request_id:String;
    public var from:String;
    public var paypalEmail:String;
    public var amount:Number;
    public var status:String="processing";

}
}
