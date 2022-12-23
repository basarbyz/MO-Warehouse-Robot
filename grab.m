function [] = grab(brick, pow, time)
%GRAB Close or open the gripper

%initialization
brick.motorA.stop()
brick.motorA.power = pow;
brick.motorA.limitMode = 'Time';
brick.motorA.limitValue = time;
%Start the Motors
brick.motorA.start();
brick.motorA.waitFor();
%Hold object when accessed
if pow < 0
    brick.motorA.power = 2 * pow;   
    brick.motorA.limitValue = 0;
    brick.motorA.start();
else
    brick.motorA.power = 0;
    brick.motorA.stop();
end
