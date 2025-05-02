#include "PowerSensorSampler.h"
#include "Printer.h"
extern Printer printer;

PowerSensorSampler::PowerSensorSampler(void) 
  : DataSource("CurrentState,VoltageState","float,float")
  // from DataSource
{}


void PowerSensorSampler::init(void)
{
  Wire1.begin();
  if (!INA.begin() )
  {
    Serial.println("could not connect. Fix and Reboot");
  }

  float shunt = 0.100;                      /* shunt (Shunt Resistance in Ohms). Lower shunt gives higher accuracy but lower current measurement range. Recommended value 0.020 Ohm. Min 0.001 Ohm */
  float current_LSB_mA = 0.05;              /* current_LSB_mA (Current Least Significant Bit in milli Amperes). Recommended values: 0.050, 0.100, 0.250, 0.500, 1, 2, 2.5 (in milli Ampere units) */
  float current_zero_offset_mA = 0;         /* current_zero_offset_mA (Current Zero Offset in milli Amperes, default = 0) */
  uint16_t bus_V_scaling_e4 = 10000;        /* bus_V_scaling_e4 (Bus Voltage Scaling Factor, default = 10000) */

  if(INA.configure(shunt, current_LSB_mA, current_zero_offset_mA, bus_V_scaling_e4)){
    Serial.println("\n***** Configuration Error! Chosen values outside range *****\n");
  } 
}


void PowerSensorSampler::updateState(void)
// This function is called in the main loop of Default_Robot.ino
{
  CurrentState = INA.getCurrent_mA();
  VoltageState = INA.getShuntVoltage_mV();
}


String PowerSensorSampler::printState(void)
// This function returns a string that the Printer class 
// can print to the serial monitor if desired
{
  return "Voltage: " + String(VoltageState) + " mV, Current: " + String(CurrentState) + " mA";
}

size_t PowerSensorSampler::writeDataBytes(unsigned char * buffer, size_t idx)
// This function writes data to the micro SD card
{
  float * data_slot = (float *) &buffer[idx];
  data_slot[0] = CurrentState;
  data_slot[1] = VoltageState;
  return idx + 2*sizeof(float);
}
