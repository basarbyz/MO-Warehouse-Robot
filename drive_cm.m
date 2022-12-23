function [] = drive_cm(brick, pow, cm_val)
%DRIVE_CM Drive specific route

%initialization
motorL = brick.motorB;
motorR = brick.motorC;
motorL.brakeMode = 'Brake';
motorR.brakeMode = 'Brake';
%Set by parameter
motorL.power = pow;
motorL.limitValue = (cm_val / 17.5 * 360);
%Start the Motors
motorL.syncedStart(motorR, 'turnRatio', 0);
motorL.waitFor();
motorR.waitFor();
motorL.syncedStop();
end

