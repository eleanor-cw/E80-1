figure(1)
clf
%extract dana point pressure data
A00danapoint= logreaderA00f(30);
pdana=A00danapoint*(3.3/1023);
%window
pdana=pdana(553: 553+350);
%Extract and window lab calibration data
A00calibration= logreaderA00f(47);
pcal=A00calibration*(3.3/1023);
pcal=pcal(285: 285+350);
%Theoretical shifted  dana point data
pdanaprime= pdana+ mean(pcal(50:end)-pdana(50:end));
plot(pdana)
hold on
plot(pdanaprime)
plot(pcal)
legend('Dana point', 'Shifted dana point','Post-processing claibration')
title('Pressure Sensor Data Analysis')
mean(pcal(50:end)-pdana(50:end))