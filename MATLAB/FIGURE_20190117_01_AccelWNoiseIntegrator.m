%% Accel Demo
% This file simulates a 1-D acceleration measured by an accelerometer with
% noise. It cacluates the true acceleration, velocity and position, and
% then adds gaussian white noise to the true acceleration to generate the
% simulated measured acceleration. It then integrates the measured
% acceleration once to get calculated velocity, and then a second time to
% get calculated position. It calculates the error bounds for the position
% and velocity based on the standard deviation of the sensor and the
% specified confidence level.
accelXg= (accelX)*.0098;
accelYg= (accelY)*.0098;
dt = 0.1; % The sampling rate
t = 0:dt:length(accelXg)*dt-dt; % The time array
% a = 1 + sin( pi*t -pi/2); % The modeled acceleration
% la = length(a);
% la2 = round(length(a)/5);
% a([la2:end]) = 0; % We only want one cycle of the sine wave.
sigma = std(accelYg); % The standard deviation of the Y data.
confLev = 0.95; % The confidence level for bounds
preie = sqrt(2)*erfinv(confLev)*sigma*sqrt(dt); % the prefix to the sqrt(t)
preiie = 2/3*preie; % The prefix to t^3/2a = 1 + sin( pi*t - pi/2);
plusie=preie*t.^0.5; % The positive noise bound for one integration
plusiie = preiie*t.^1.5; % The positive noise bound for double integration
% en = sigma*randn(1, la); % Generate the noise
vx = cumtrapz(t,accelXg); % Integrate the true acceleration to get the true velocity
vy = cumtrapz(t,accelYg); % Integrate the true acceleration to get the true velocity
rx = cumtrapz(t,vx); % Integrate the true velocity to get the true position.
ry = cumtrapz(t,vy); % Integrate the true velocity to get the true position.
% % an = a + en; % Generate the noisy measured acceleration
% vn = cumtrapz(t,an); % Integrate the measured acceleration to get the velocity
% vnp = vn + plusie; % Velocity plus confidence bound
% vnm = vn - plusie; % Velocity minus confidence bound
% rn = cumtrapz(t,vn); % Integrate the velocity to get the position
rnp = ry + plusiie'; % Position plus confidence bound
rnm = ry - plusiie'; % Position minus confidence bound
truerx= 0:.01: 0.5;
truery= zeros(1, length(truerx));
clf
figure(1)
plot(rx, ry,'linewidth',2)
hold on
plot(truerx, truery,'linewidth',2)
xlabel('X displacement(m)')
ylabel('Y displacement(m)')
title('Measured and True Y displacement vs X displacement')
legend('Measured displacement', 'True displacement')
figure(2)
plot(t, ry, t, rnp,'-.', t, rnm,'-.')
xlabel('time(s)')
ylabel('Y displacement(m)')
title('Measured Y displacement vs time with confidence bounds')
legend('Measured displacement', 'Upper confidence bounds', 'Lower confidence bounds')

 % hold on
% plot(t, an)
% hold off
% xlabel('Time (s)')
% ylabel('Acceleration')
% title('True and Measured Acceleration')
% legend('True Acceleration','Measured Acceleration','location','northeast')
% figure(2)
% plot(t, v, t, vn, t, vnp,'-.', t, vnm,'-.')
% xlabel('Time (s)')
% ylabel('Velocity')
% title('Calculated Velocity from Measured Acceleration')
% legend('True Velocity','Calculated Velocity','Upper Confidence Bound',...
%     'Lower Confidence Bound','location','southeast')
% figure(3)
% plot(t, r, t, rn, t, rnp,'-.', t, rnm,'-.')
% xlabel('Time (s)')
% ylabel('Position')
% title('Calculated Position from Measured Acceleration')
% legend('True Velocity','Calculated Velocity','Upper Confidence Bound',...
%     'Lower Confidence Bound','location','southeast')
