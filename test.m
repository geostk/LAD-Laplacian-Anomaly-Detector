%TEST Tests a single algorithm against a single test scenario
clear;

%% Implanted anomaly
% load('salinas_impl_4.mat');
% load('salinas_impl_14.mat');
% 
% load('salinas_impl_gt.mat');

%% Real anomaly
load('salinas.mat');
load('salinas_gt.mat');

%% Detector
e = 0.99;
alpha = nnz(gt)/numel(gt);

out = rxd(X);
% out = rxd_S(X);
% out = wscf(X);
% out = rsad(X, alpha);
% out = lad_Q(X);
% out = lad_Q_S(X);
% out = lad_C(X);
% out = lad_C_S(X);
% out = rxd_PCA(X, e);
% out = rxd_PCA_S(X, e);
% out = lad_Q_PCA(X, e);
% out = lad_Q_PCA_S(X, e);
% out = lad_C_PCA(X, e);
% out = lad_C_PCA_S(X, e);

%% Test
if islogical(out)
    result = metrics(out, gt);
else
    result = metrics(out>=0, gt);
    for p = 0:0.02:1
        restemp = metrics(out>max(out(:))*p, gt);
         if restemp(7) > result(7)
            result = restemp;
         end
         disp(['p: ' num2str(p) ' - SOI: ' num2str(restemp(7))]);
    end
end

result