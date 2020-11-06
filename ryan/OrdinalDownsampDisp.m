function fig = OrdinalDownsampDisp(imgin, varargin)
%
% OrdinalDownsampDisp
%
% Author: Kinchung (Ryan) Wong
%
% Package namespace: "ryan.OrdinalDownsampDisp"
%
% License type: MIT License
%
% See also: "ryan.OrdinalDownsamp"
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
