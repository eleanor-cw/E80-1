%file 53
windcalibrate= u./10000;
windcalibratesens=-(180/pi).*windcalibrate(457:550);
windcalibrateimu=headingIMU(457:550);
figure(1)
clf
plot(motorA)
hold on
plot(motorB)
plot(motorC)
plot(u./10000*(180/pi))
plot(headingIMU)
legend('right motor','middle motor', 'left motor', 'rotary output','heading')
xlim([457 1769])

%note large imu spikes in  -30-> -180 degree range
%note imu was  facing  the back of the bot


