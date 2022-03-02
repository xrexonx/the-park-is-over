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
  * un-park
    * parking_id
    * exit_datetime

### High level pseudocode
* park
  * Check and get nearest available slot by entry point and vehicle type
    * if there is available slot
      * Check if vehicle already parked and return within an hour
        * if true
          * Update the existing parking data with the new slot selected
        * else
          * Create new parking data
        * end
        * Update the slot to occupied
        * Return parking data
    * else
      * Return no available slot message
    * end
      
* un-park
  * Get parking data by id
    * if parking
      * Check parking data if it has already a exit datetime value, which means the vehicle parked already and come back
        * if parking has exit_datetime
          * Get parking duration using the exit datetime and the new exit datetime
        * else
          * Get parking duration using the entry datetime and exit datetime
        * end
        * Compute amount using duration * parking slot rate depends on the vehicle type
        * Create new Payment record
        * Update parking slot to available
        * Return parking and payment information
    * else
      * Return no parking data found
    * end
    
