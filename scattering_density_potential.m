function [x,y,scatter_num]=scattering_density_potential(angle_init, dt, dense)
% x : x-cordinate
% y : y-value for the 
%
xmax = 360;
c = 1;
esp = 10;
size = 1000;
x = ones(size,1);
y = ones(size,1);

scattering_interval=rand*dense;
scattering_height = (-1)*scattering_interval;

t = 0;
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
        if (yi <= scattering_height)
            scattering_interval=rand(1)*dense;
            scattering_interval = (-1)*scattering_interval;
            scattering_height = scattering_height + scattering_interval;
            angle_init = xmax*rand(1);

             hitpointx = x(i-1);
             hitpointy = y(i-1);

            scatter_num = scatter_num + 1;
            t = 0;
        end
     x(i) = xi;
     y(i) = yi;
    
    t = t + dt;
end
x = x(:,1); y = y(:,1);
scatter(x,y);
%scatter(x,y);