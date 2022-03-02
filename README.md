# When the Parking is ovah
Cause our mouth just have run dra

### Given:
* Entry points
* Vehicle Types
* Parking slots

### Database: parkingDB
### Tables:
 * EntryPoint
   * id
   * name
   * slots
   * timestamps
 * Slot
   * id
   * entry_point_id
   * parking_id
   * name (s,m,l) {id_point_type}
   * rate
   * status (green,red)
   * timestamps
 * Parking
   * id
   * entry_datetime
   * exit_datetime
   * vehicle_type
   * plate_number
   * timestamps
 * Payment
   * id
   * duration
   * parking_id
   * amount
   * timestamps

### Constants
* Base parking rate
* Vehicle types

### Resource
* Parking
  * park
    * entry_datetime
    * vehicle_type
    * plate_number
    * entry_point
  * unpark
    * park_id
    * exit_datetime
    
