#include "PowerSensorSampler.h"
#include "Printer.h"

extern Printer printer;

PowerSensorSampler::PowerSensorSampler(void) 
  : DataSource("Power, Current","float, float") // from DataSource
{}


void PowerSensorSampler::init(void)
{
  Wire1.begin();
  if (!INA.begin() )
  {
    Serial.println("could not connect. Fix and Reboot");
  }
  INA.setMaxCurrentShunt(1, 0.1);hgff
}


void PowerSensorSampler::updateState(void)
// This function is called in the main loop of Default_Robot.ino
{
  CurrentState = INA.getCurrent_mA();
  PowerState = INA.getPower_mW();
}


String PowerSensorSampler::printState(void)
// This function returns a string that the Printer class 
// can print to the serial monitor if desired
{
  return "Power: " + String(PowerState) + " mW, Current: " + String(CurrentState) + " mA";
}

size_t PowerSensorSampler::writeDataBytes(unsigned char * buffer, size_t idx)
// This function writes data to the micro SD card
{
  float * data_slot = (float *) &buffer[idx];
  data_slot[0] = CurrentState;
  data_slot[1] = PowerState;
  return idx + sizeof(2*float);
}
