#ifndef __POWERSENSORSAMPLER_h__
#define __POWERSENSORSAMPLER_h__

#include <Arduino.h>
#include "DataSource.h"
#include "Pinouts.h"



class PowerSensorSampler : public DataSource
{
public:
  PowerSensorSampler(void);

  void init(void);

  // Managing state
  float PowerState;
  float CurrentState;
  void updateState(void);
  String printState(void);

  // Write out
  size_t writeDataBytes(unsigned char * buffer, size_t idx);

  int lastExecutionTime = -1;
  
};

#endif