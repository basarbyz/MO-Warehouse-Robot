function [] = drive_line(brick, pow)
%DRIVE_LINE to the next cross line

%initialization
motorL = brick.motorB;
motorR = brick.motorC;
motorL.brakeMode = 'Brake';
motorL.power = pow;
motorL.limitValue = 0;
%Start the Motors
motorL.syncedStart(motorR, 'turnRatio', 0);
while(brick.sensor1.value >= 90) %Abort condition by color sensor
end
motorL.syncedStop();
motorL.waitFor();
motorR.waitFor();
end

