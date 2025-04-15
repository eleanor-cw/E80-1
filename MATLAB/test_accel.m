clf
figure(1)
plot(accelX)
hold on
plot(accelY)
plot(accelZ)
plot(motorA)
xlim([272, 445])
legend('x', 'y', 'z', 'motor')