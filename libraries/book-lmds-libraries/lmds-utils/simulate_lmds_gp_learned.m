function data = simulate_lmds_gp_learned(target, limits, fig1, ls, A, data)

% target = [0; 0];

reshape_btn = uicontrol('Position',[390 10 110 25],'String','Reshape',...
              'Callback','uiresume(gcbf)');

% Plot Attractor
scatter(target(1),target(2),50,[0 0 0],'+'); hold on;

% Construct and plot chosen Linear DS
ds_lin = @(x) lin_ds(x, target, A);
hs = plot_ds_model_mod(fig1, ds_lin, target, limits,'low'); hold on;
% axis tight
title('Original Linear Dynamics $\dot{x}=f_o(x)$', 'Interpreter','LaTex')

% Pop-up hand-drawing mouse data GUI
if isempty(data)
    data = draw_mouse_data_on_DS(fig1, limits);
    disp('Press Button to Reshape DS');
    uiwait(gcf); 
else
    plot(data{1}(1,:),data{1}(2,:),'r.','markersize',10)
end

Data = [];
for l=1:length(data)
    Data = [Data data{l}];
end

% Construct LMDS Data for Original Linear Dynamics
lmds_data = [];
dsi = 1;
dei = length(Data);
thres = 0.005;
lmds_data = [lmds_data, generate_lmds_data_2d(Data(1:2,dsi:dei)-repmat(target,[1 length(Data)]),Data(3:4,dsi:dei),ds_lin(Data(1:2,dsi:dei)-repmat(target,[1 length(Data)])),thres)];

% Reshape 'Original Dynamics with GP-MDS'
% hyper-parameters for gaussian process        
% these can be learned from data but we will use predetermined values here
%         ell = 0.15; % lengthscale. bigger lengthscale => smoother, less precise ds
% ell = 0.25; % lengthscale. bigger lengthscale => smoother, less precise ds
ell = ls;
sf = 0.2; % signal variance
sn = 0.2; % measurement noise        

% we pack the hyper paramters in logarithmic form in a structure
hyp.cov = log([ell; sf]);
hyp.lik = log(sn);
% for convenience we create a function handle to gpr with these hyper
% parameters and with our choice of mean, covaraince and likelihood
% functions. Refer to gpml documentation for details about this.
gp_handle = @(train_in, train_out, query_in) gp(hyp, ...
    @infExact, {@meanZero},{@covSEiso}, @likGauss, ...
    train_in, train_out, query_in);
       
% Define our reshaped dynamics
reshaped_ds = @(x) gp_mds_2d(ds_lin, gp_handle, lmds_data, x);        
% Delete lin DS model
delete(hs)
% Plot variance, to understand where the gp has influence             
hv = plot_gp_variance_2d(limits, gp_handle, lmds_data(1:2,:)+repmat(target, 1,size(lmds_data,2)));    

hs = plot_ds_model_mod(fig1, reshaped_ds, target, limits, 'low');
title('Reshaped Dynamics $\dot{x}=f(x)=M(x)f_o(x)$ ', 'Interpreter','LaTex')
display('Reshaping Done.');

delete(reshape_btn)
end