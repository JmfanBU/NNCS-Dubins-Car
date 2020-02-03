% Target Set
plot( [1.25, 2, 2, 1.25, 1.25], [-3.5,-3.5,-2.75,-2.75,-3.5] , 'color' , [72/255 130/255 197/255], 'LineWidth', 2.0);
hold on;
clear;

Ts = 0.2;  % Sample Time
N = 3;    % Prediction horizon
Duration = 8; % Simulation horizon

global simulation_result;
simulation_x = zeros(100, 1700);
simulation_y = zeros(100, 1700);

% Initial sets limits [-1,1]^2

for m=1:100

x0 = -4.5 + 0.1*rand(1);
y0 = 0 + 0.1*rand(1);
z0 = 0 + 0.1*rand(1);
x = [x0;y0;z0];

simulation_result = x;

% Things specfic to the model  ends here

options = optimoptions('fmincon','Algorithm','sqp','Display','none');
uopt = zeros(N,1);

u_max = 0;

x_now = zeros(3,1);
x_next = zeros(3,1);
z = zeros(4,1);

x_now = x;

% Start simulation
for ct = 1:(Duration/Ts) 
     u = NN_output_relu_tanh(x_now,0,1,'nn_relu_tanh_100');
     
     z(1) = x_now(1) ;
     z(2) = x_now(2) ;
     z(3) = x_now(3) ;

     z(4) = u ;

     x_next = system_eq_dis(x_now, Ts, u);
     x = x_next;
     x_now = x_next;
end

plot(simulation_result(1,:),simulation_result(2,:), 'color', [223/255, 67/255, 69/255]);

set(gca,'FontSize',16)
hold on;
dim = size(simulation_result);
simulation_x(m, 1:dim(2)) = simulation_result(1,:);
simulation_x(m, dim(2):end) = simulation_result(1, end);
simulation_y(m, 1:dim(2)) = simulation_result(2,:);
simulation_y(m, dim(2):end) = simulation_result(2, end);

end

% Wall
line([5.142, -5.315], [-5.591, -5.591], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);
line([-5.315, -5.315], [-5.591, 1], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);
line([5.142, 5.142], [-5.591, 1], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);
line([3.030, -2.236], [-2.374, -2.374], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);
line([3.030, 3.030], [-2.374, 1], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);
line([-2.236, -2.236], [-2.374, 1], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);

% Barrel
line([-1.25, -1.25], [-4.25, -3.75], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);
line([-0.75, -0.75], [-4.25, -3.75], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);
line([-1.25, -0.75], [-4.25, -4.25], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);
line([-1.25, -0.75], [-3.75, -3.75], 'LineWidth', 3, 'color', [237/255, 201/255, 72/255]);

fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
text(0, 0.7, 'L=100.0', 'FontSize',18);
text(0, 0.1, 'ReLU-tanh', 'FontSize',18);
print(fig,'./Benchmarks/dubinscar_relu_tanh_100','-dpdf')
export_fig ./Benchmarks/dubinscar_relu_tanh_100.pdf