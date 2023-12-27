% Two interacting tank system 
% Task (1)- System identification - parameters , input, disturbances, and control variables
% Task (2)- Nonlinear System Steady State
% Task (3)- Linearization of Nonlinear Model
% Tast (4)- Step Change Experiment 10 percent and 20 percent 
% Task (5)- Comparison and Analysis
% Task (6)- System Characterization 

clear all % To clear historical data in workspace 
clc   % clear variables in the command window

% Defining Input Variable
global qi
qi= 16;



% Initial Guess for Heights

h1_initial = 2;
h2_initial = 1;


% Generating Steady state conditions (Non-Linear Model)

for i= 1:1:800


    [t,H] = ode45(@two_tanks, [0 0.05], [h1_initial, h2_initial]);

    % Storing values of H1 and h2
    h1_profile(i,1)= H(end, 1);
    h2_profile(i,1)= H(end, 2);
    
    % Creating Time Profile
    time_profile(i, 1) = i;
    
    % Updating Inital Guesses
    h1_initial = H(end, 1);
    h2_initial = H(end, 2);

end 

% Graph steady state profile of the system 
figure(1)
subplot(211), plot(time_profile(:), h1_profile(:), 'g', xlabel('Time'), ylabel('Height(H1)'));
hold on 
subplot(212), plot(time_profile(:), h2_profile(:), 'b', xlabel('Time'), ylabel('Height(H2)'));

% Saving steady state data
h1_steady = H(end,1);
h2_steady = H(end,2);

% Making inital guesses as steady state
 h1_initial = H(end,1);
 h2_initial = H(end,2);

% Plant simulation 


% Loop for step change simulation
for i= 1:1:800  
for j= 1:1:2

% 10% INCREASE M= step change (10 percent of initial value of qi i.e 10 %of 16)
    if j==1
        if i<100
            M=0;  % Magnitute of step change is zero (i.e system is at steady state)
            qi = 16 + M;  % step change 
        else
            M = 1.6;   % Magnitude of step change in qi is 10% from initial steady state value 
            qi = 16 + M;  
        end


 % Non-Linear Model Response 
     [t,H] = ode45(@two_tanks, [0 0.1],[h1_initial; h2_initial]);
     h1_profile_M1(i,1) = H(end,1);  % Saving the end values 
     h2_profile_M1(i,1) = H(end,2);  %Saving the end values

     Time_profile_M1(i,1) = i ;
                                                 
     h1_initial = H(end,1);               % guess for next integration
     h2_initial = H(end,2);

     
  % Linear Model Response (obtained by linearizing the non-linear model )
     if i>100
         h2_10(i) = I_laplace_10per(i-100)+h2_steady;
     else
         h2_10(i) = h2_steady;
     end

 % 20% Increase In Input M= step change (20 percent of initial value of qi i.e 10 %of 16)
    end
      if j==2
        if i<100
            M=0;        % Magnitute of step change is zero (i.e system is at steady state)
            qi = 16 + M;  % step change 
        else
            M = 3.2;    % Magnitude of step change in qi is 20% from initial steady state value
            qi = 16 + M;
        end


     % Non-Linear Model Response 
     [t,H] = ode45(@two_tanks, [0 0.1],[h1_initial; h2_initial]);
     h1_profile_M2(i,1) = H(end,1);   % Saving the end values
     h2_profile_M2(i,1) = H(end,2);

     Time_profile_M2(i,1) = i;

     h1_initial = H(end,1);
     h2_initial = H(end,2);



     % Linear Model Response (obtained by linearizing the non-linear model )
     if i>100
         h2_20(i) = I_laplace_20per(i-100)+h2_steady;
     else
         h2_20(i) = h2_steady;
     end
      
    end
end
end

figure(2)
 plot(Time_profile_M1(:),h2_profile_M1(:),'b',Time_profile_M1(:),h2_10(:),'g')

figure(3)
 plot(Time_profile_M1(:),h2_profile_M2(:),'b',Time_profile_M1(:),h2_20(:),'g')

 

