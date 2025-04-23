#ifndef __POWERSENSORSAMPLER_h__
#define __POWERSENSORSAMPLER_h__

#include <Arduino.h>
#include "DataSource.h"
#include "Pinouts.h"
#include "Wire.h"
#include "INA226.h"



class PowerSensorSampler : public DataSource
{
public:
  PowerSensorSampler(void);

  void init(void);

  // Managing state
  INA226 INA;
  float VoltageState;
  float CurrentState;
  void updateState(void);
  String printState(void);

  // Write out
  size_t writeDataBytes(unsigned char * buffer, size_t idx);

  int lastExecutionTime = -1;
  
};

#endif