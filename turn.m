function [] = turn(brick, pow, angle)
%TURN drehung um bestimmten Winkel

%Initialisierung
motorL = brick.motorB;
motorR = brick.motorC;
motorL.brakeMode = 'Brake';
motorL.power = pow;
motorL.limitValue = 0;
start_val = brick.sensor3.value;
%Start der Drehung
motorL.syncedStart(motorR, 'turnRatio', 200);
while(abs(brick.sensor3.value - start_val) <= angle) %Abruchbedingung durch Gyro-Sensor
    brick.sensor3.value;
end
motorL.syncedStop();
end

