windowmean=20;
accelXavg=movmean(accelX, windowmean);
windowmed= 20;
accelXmed=medfilt1(accelX, windowmed);
clf
plot(motorA)
hold on
plot(accelX)
% plot(accelXmed)
xlim([576 940])
legend('motor', 'running avg')