function [] = lineFollow_cm(brick, pow, cm)
%LINEFOLLOW_CM Follows the line for a specified distance

%initialization
motorL = brick.motorB;
motorR = brick.motorC;
motorL.brakeMode = 'Brake';
motorR.brakeMode = 'Brake';
motorL.limitValue = 0;
motorR.limitValue = 0;
motorL.power = 0;
motorR.power = 0;
sensorM = brick.sensor2;
live_val = 0;
integral = 0;
last = 0;
average = 35;
road = cm / 17.5 * 360; % Calculation of required rotation

%Start of the loop or motors
motorL.start();
motorR.start();
start_val = motorL.tachoCount;
while(live_val < start_val + road) % Abort condition by speedometer of the engines
    live_val = motorL.tachoCount();
    value = sensorM.value;
    error = value - average; %Determine deviation by average
    integral = error + integral / 2;
    speedL = pow - (0.15 * error + 0.1 * integral + 0.2 * (error - last)); % Adjust the speeds of the motors -> steering in the desired direction
    speedR =  pow + (0.15 * error + 0.1 * integral + 0.2 * (error - last));
    motorL.power = speedL;
    motorR.power = speedR;
    last = error;
end
motorL.stop();
motorR.stop();