%file 53
windcalibrate= u./10000;
windcalibratesens=-(180/pi).*windcalibrate(457:550);
windcalibrateimu=headingIMU(457:550);
avgwind=windcalibrateimu+windcalibratesens;
figure(1)
clf
plot(motorA)
hold on
plot(motorB)
plot(motorC)
plot(u./10000*(180/pi))
plot(headingIMU)
plot(mean(avgwind)*ones(size(motorA)))
legend('right motor','middle motor', 'left motor', 'rotary output','heading'...
    ,'avgwind')
xlim([457 1769])
figure(2)
clf
plot(avgwind)
hold on
plot(windcalibrateimu)
legend('wind','heading')
%note -14 degrees heading appears to be wind direction
%wind direction was ExNE which would correspond with east being 0 degrees
%with counterclockwise being negative
%test heading output  of  teensy when facing S N E and W

