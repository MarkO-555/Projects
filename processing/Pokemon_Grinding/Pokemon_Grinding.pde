import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.AWTException;
import java.lang.Object;


void start(){
  try{
    while(true){
      Robot robot = new Robot();
      
      robot.keyPress(KeyEvent.VK_A);
      robot.keyRelease(KeyEvent.VK_A);
      
    }
  }
  catch(AWTException exception){
    println("ERROR",exception);
  }
}
