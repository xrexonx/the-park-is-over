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
   * name (s,m,l) {id_point_type}
   * rate
   * status (0,1)
   * timestamps
 * Parking
   * id
   * entry_datetime
   * exit_datetime
   * vehicle_type
   * slot_number
   * plate_number
   * entry_point
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
  * unpark
    * park_id

### Todos
* Create design for entry point/slots data
* Create seeder for entry point and slots
* 
