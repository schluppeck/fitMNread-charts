%% ideas / example of how to fit MN read data with piece-wise linear
%
% ds 2019-11-07

% sample data (approximately what's in the PNG file in this folder)
printSize = -0.5:0.1:1; % in log units
readingSpeed = [7, 13, 27, 75, 120, 133, 150, 133, 120, 133, 150, 120, 133, 150, 133, 150]; % kind of like the data... in WPM

%% plot

f_ = figure;
dataFitPlot(printSize, readingSpeed, [] )
xlabel('printSize (logMAR)')
ylabel('reading speed (wpm)')



%% now look at a "piece-wise linear function"
%
% this version is parametrised such that it has a ramp followed by a
% plateau. this is the pattern in the MN read summary charts.

figure
p = [ 0.5, 0.2, 1 ]; % KNEE point, height of plataeu and gradient of ramp
Y = pieceWiseLinear(p, printSize);

plot(printSize, Y, 'linewidth', 2); % example plot


%% now fit the data and replot...

% X = lsqcurvefit(FUN,X0,XDATA,YDATA)

params = lsqcurvefit(@pieceWiseLinear, [0, 130, 10], printSize, readingSpeed );

fitX = linspace(min(printSize), max(printSize), 101);
fitY = pieceWiseLinear(params, fitX);

figure
dataFitPlot(printSize, readingSpeed, [] , fitX, fitY);

title(sprintf('knee point at: %.2f, plateau at: %.2f', params(1), params(2)))

%% now make a function that can fit - needs to be at end of file!
%
% idea... pieceWiseLinear(p, x)
% where 
%         p[1] = ... p_c  the point at which the curve bends
%         p[2] = .... h the height of the plateau
%         p[3] = .... m the gradient of the slopey bit


%%

