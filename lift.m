function [] = lift(brick, pow, time)
%LIFT moves the gripper up and down 
brick.motorD.power = pow;
brick.motorD.limitMode = 'Time';
brick.motorD.limitValue = time;
brick.motorD.start();
brick.motorD.waitFor();
end