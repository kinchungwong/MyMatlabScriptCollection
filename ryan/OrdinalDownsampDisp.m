function fig = OrdinalDownsampDisp(imgin, varargin)
% OrdinalDownsampDisp displays the output of OrdinalDownsamp as a MATLAB
% tiled-layout figure consisting of multiple slices of rank-statistic.
%
% Usage:
%     fig = OrdinalDownsampDisp(imgin, varargin)
%
% All arguments are passed intact into OrdinalDownsamp. This function
% is responsible for extracting image slices of rank-statistic, and for
% displaying all of them in a MATLAB figure.
%
% This script is part of my personal collection of MATLAB scripts.
% URL: https://github.com/kinchungwong/MyMatlabScriptCollection
% Refer to LICENSE for copyright and license information
%

[imgout, args] = ryan.OrdinalDownsamp(imgin, varargin{:});

tilem = args.m;
tilen = args.n;
tilemax = max(tilem, tilen);

tlo = tiledlayout('flow');
tlo.TileSpacing = 'none';
tlo.Padding = 'none';

for kFig = 1:tilemax
    ofsm = round((kFig - 1) * (tilem - 1) / max(eps, (tilemax - 1))) + 1;
    ofsn = round((kFig - 1) * (tilen - 1) / max(eps, (tilemax - 1))) + 1;
    nexttile
    imshow(imgout(ofsm:tilem:end, ofsn:tilen:end, :));
end

if nargout >= 1
    fig = gcf;
end
