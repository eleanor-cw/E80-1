%file 53
rotarysens=-u./10000*(180/pi);
%Find true heading of the front of the bot
offset = -30;  % IMU 0° = -30° true heading
    % Step 1: Adjust for the IMU's misalignment
    corrected_heading = headingIMU + offset;

    % Step 2: Flip to get front-of-bot heading (since IMU is on back)
    trueheadingRobot = corrected_heading + 180;

    % Step 3: Wrap to [-180, 180]
    trueheadingRobot = mod(trueheadingRobot + 180, 360) - 180;
%Estimate wind as longest period of 0 degree rotatry output
avgwind= mean(headingIMU(1236:1275))+180-30;
avgwind= avgwind*ones(size(headingIMU));
figure(1)
clf
plot(trueheadingRobot)
hold on
plot(avgwind,'Color', [1, 0.5, 0])
plot(rotarysens)
plot(headingIMU)
% Highlight the section used for average wind (samples 1236 to 1275)
%To
yl = ylim;
fill([1236 1275 1275 1236], [yl(1) yl(1) yl(2) yl(2)], ...
     [1 .5 0], ...        % RGB color: [R G B], where 1 = white, 0 = black
     'FaceAlpha', 0.5, ...     % Transparency: 0 = fully transparent, 1 = opaque
     'EdgeColor', 'none', ...  % Border color; set to 'none' to remove edge
     'DisplayName', 'Wind estimate region')
% Add label near the center of the shaded region
text(1100, yl(2) - 10, {'Avg wind', 'calc region'}, ...
     'HorizontalAlignment', 'center', ...
     'VerticalAlignment', 'top', ...
     'FontSize', 8, ...
     'FontWeight', 'bold', ...
     'Color', [1 .5 0])  % Change color as desired
%Graph settings
legend('Adjusted robot heading', 'Estimated wind direction'...
    , 'Rotary sensor output', 'IMU ouput')
xlabel("Samples")
ylabel("Degrees")
title("Wind Correction Analysis (N=0 degrees)")
xlim([457 1769])

%note large imu spikes in  -30-> -180 degree range
%note imu was  facing  the back of the bot


