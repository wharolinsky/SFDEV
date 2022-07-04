public class InventoryDataScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {

         
        String cronTime= '30 19 * * * ?';

        InventoryDataSchedulerHandler.ScheduleCallOut();   

    }
}
