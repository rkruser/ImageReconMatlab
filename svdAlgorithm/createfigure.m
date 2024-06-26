function createfigure(X1, Y1, xlab, ylab)
%CREATEFIGURE(X1, Y1, S1, C1)
%  X1:  scatter x
%  Y1:  scatter y
%  xlab: x-axis label
%  ylab: y-axis label

%  Auto-generated by MATLAB on 21-Jul-2014 14:44:30

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1); %,...
    %'Position',[0.13 0.345256609642302 0.27 0.579743390357699]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[-0.073106095220689 99.9268939047793]);
xlim(axes1,[0,100]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 100]);
hold(axes1,'all');

% Create scatter
scatter(X1,Y1,'MarkerFaceColor',[0 0 1],'MarkerEdgeColor','none');

% Create xlabel
%xlabel({'Percent of Pixels Removed'});
xlabel({xlab});

% Create ylabel
%ylabel({'Feature Count Minimizing RMSE'});
ylabel({ylab});

% Create title
%title({'Optimal Feature Counts at Varying Levels of Sparsity'},...
%    'FontSize',12);

