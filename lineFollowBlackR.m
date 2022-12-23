function [] = lineFollowBlackR(brick, pow)
%LINEFOLLOWBLACKR Follows the line to the next right cross line

%Initialize the motors, sensors and variables
motorL = brick.motorB;
motorR = brick.motorC;
motorL.brakeMode = 'Brake';
motorR.brakeMode = 'Brake';
motorL.limitValue = 0;
motorR.limitValue = 0;
sensorM = brick.sensor2;
sensorR = brick.sensor1;
motorL.power = 0;
motorR.power = 0;
average = 33;
integral = 0;
last = 0;

% Start of the loop or motors
motorL.start();
motorR.start();
while(sensorR.value >= 90) %Abort condition by second color sensor
    value = sensorM.value;
    error = value - average; % Determine deviation by mean
    integral = error + integral / 2;
    speedL = pow - (0.03 * error + 0.1 * integral + 0.15 * (error - last)); % Adjust the speeds of the motors -> steering in the desired direction
    speedR =  pow + (0.03 * error + 0.1 * integral + 0.15 * (error - last));
    motorL.power = speedL;
    motorR.power = speedR;
    last = error;
end
motorL.stop();
motorR.stop();
