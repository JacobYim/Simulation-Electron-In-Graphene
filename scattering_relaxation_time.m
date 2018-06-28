function [x,y,scatter_num]=scattering_relaxation_time(angle_init, dt, relax_time)
% this function is for simulating the electron in graphene which behiave like the massless particles.
% the considered factors are 
%   1. the electric field is on.
%   2. assume that the electron collide with the proton potential within
%   relaxation time.

% x : x-cordinate
% y : y-value for the 
%

xmax = 360;
c = 1;
esp = 10;
size = 1000;
x = ones(size,1);
y = ones(size,1);
x = x(:,1); y = y(:,1);

% scattering_interval=rand*dense;
% scattering_height = (-1)*scattering_interval;

t = 0;          % a variable for counting relaxation time
time = 0;       % a variable for real time
hitpointx = 0;
hitpointy = 0;
scatter_num = 0;

for i = 1:size
    
    a = c*cosd(angle_init);
    b = -c*sind(angle_init)+esp.*t;
    d = sqrt(a.^2+b.^2);
    z = c.*(1-sind(angle_init));
   
    xi = hitpointx+c*a/esp.*log((d+b)/z);
    yi = hitpointy-c/esp.*d+c^2/esp;
        if (t >= relax_time)                                                % when the t is larger than relaxation time, scattering occurred.
            
            % After scattering, initialize the properties. 
            angle_init = xmax*rand(1);

            hitpointx = x(i-1);
            hitpointy = y(i-1);

            scatter_num = scatter_num + 1;
            t = 0;
        end
     x(i) = xi;
     y(i) = yi;
    
    t = t + dt;             % add dt to t for counting the relaxtion time
    time = time + dt;       % real time count
    
end

scatter(x,y);