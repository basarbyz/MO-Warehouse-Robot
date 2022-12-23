function [] = lineFollow_black_slow(brick, pow)
%LINEFOLLOWBLACK_SLOW

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
integral = 0;
last = 0;
average = 33;

%start of the loop
motorL.start();
motorR.start();
while(sensorR.value >= 90) %Abort condition by second color sensor
    value = sensorM.value;
    error = value - average; % Determine deviation by average
    integral = error + integral / 2;
    speedL = pow - (0.1 * error + 0.1 * integral + 0.2 * (error - last)); % Adjust the speeds of the motors -> steering in the desired direction
    speedR =  pow + (0.1 * error + 0.1 * integral + 0.2 * (error - last));
    motorL.power = speedL;
    motorR.power = speedR;
    last = error;
end
motorL.stop();
motorR.stop();
