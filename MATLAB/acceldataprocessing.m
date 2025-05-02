%file 30
basemass= 3409; %mass in grams w/o water
towerarea = 75.012; %area of tower in cm squared
depthcalslope= -17.3; %slope of voltage to depth curve (v-> cm)
depthcalint= 55;%intercept of calibration curve
pressurevolt= (3.3/1023)*double(A00);%pressure sensor output voltage
waterdepth= depthcalint + depthcalslope.*pressurevolt;% mass of water
watermass= waterdepth.*towerarea;
robotmass= basemass+ watermass;
windowmean=20;
accelXavg=movmean(accelX, windowmean);
windowmed= 20;
accelXmed=medfilt1(accelX, windowmed);
figure(4)
clf
plot(motorA)
hold on
plot(accelXavg)
% plot(accelXmed)
xlim([576 940])
legend('motor', 'running avg')
figure(5)
plot(A00)
xlim([576 940])