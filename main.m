function [success] = main(brick, item, storage, state)
%Main function, works the tasks taking into account the parameters
%one after the other

%Return value to check the full pass
success = 1;
%Abort on errors
try
    %Get or bring query
    if strcmp(state, 'Bringen')
        grab(brick, -30, 500);
        lift(brick, -50, 1000);
    end
    %Navigation to the first intersection
    turn(brick, 20, 190);
    lineFollow_black_slow(brick, 10);
    drive_cm(brick, 20, 4);
    brick.beep();
    
    %Query whether to continue driving
    if item == 2 || strcmp(state, 'Bringen')     
        lineFollow_cm_fast(brick, 30, 16);        
        lineFollow_black_slow(brick, 10);
        drive_cm(brick, 20, 4);
        brick.beep();
    end
    
    %Query warehouse or disposal
    if strcmp(state, 'Holen')
        %Navigation to camp
        drive_cm(brick, 20, 4);
        turn(brick, 20, 80);
        
        %Adjusting the elevator depending on the stack height
        if storage(item) == 3
            lift(brick, -50, 1000)
        else
            if storage(item) == 2
                lift(brick, -50, 500)
            end
        end
        
        %collect object
        lineFollowBlackR(brick, 20);
        grab(brick, -30, 500);
        
        %Lift all the way up depending on position
        switch storage(item)
            case 3
                lift(brick, -30, 250);
            case 2
                lift(brick, -30, 700);
            case 1
                lift(brick, -30, 1200);
        end
        
        %Navigation to the intersection
        drive_cm(brick, -30, 8);
        drive_line(brick, -30);
        drive_cm(brick, 30, 8);
        turn(brick, 20, 90);
    else
        %query container
        if item == 1
            turn(brick, -20, 10);
        else
            turn(brick, 20, 10);
        end
        
        %drop object
        drive_cm(brick, 10, 7);
        grab(brick, 30, 500);
        
        %Navigation to the junction (depending on the container)
        if item == 2
            drive_cm(brick, -10, 8);
        else
            drive_cm(brick, -10, 3);
        end
        grab(brick, -30, 500)
        if item == 1
            turn(brick, -20, 145);
        else
            turn(brick, -20, 180);
        end
    end
    
    %Navigation to the starting point
    lineFollow_cm_fast(brick, 30, 16 * item);
    lineFollow_black_slow(brick, 20);
    
    %dropping the object
    lift(brick, 40, 1200);
    grab(brick, 30, 500);
    brick.beep();
    pause(0.2);
    brick.beep();
    pause(0.2);
    brick.beep();
    brick.motorA.stop();
catch e
    %error message
    fprintf(1,'The identifier was:\n%s',e.identifier);
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    success = 0;
end
end

