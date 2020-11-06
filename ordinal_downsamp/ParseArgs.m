function args = ParseArgs(varargin)

    % Imported functions
    DefaultArgs = @ordinal_downsamp.DefaultArgs;
    ParseTileOrder = @ordinal_downsamp.ParseTileOrder;
    BuiltinPostprocs = @ordinal_downsamp.BuiltinPostprocs;

    % Attribute-based argument validation 
    is0or1 = @(v)(v == 0 || v == 1);
    is1or2 = @(v)(v == 1 || v == 2);
    isintvalue = @(v)(all(round(v) == v));
    ispos = @(v)(all(v > 0));
    istileordervalue = @(v)(ParseTileOrder(v) >= 0);
    isfunc = @(v)(isscalar(v) && isa(v, 'function_handle'));
    ischarvec = @(v)(ischar(v) && isvector(v));
    
    % Input parser
    pp = inputParser;
    pp.FunctionName = 'ryan.OrdinalDownsamp';
    
    % Predefined default values
    defaults = DefaultArgs();
    
    % Argument "m" (tile height; number of rows per tile)
    % Note: caller can pass in [m, n], which will remove the need to
    % specify n separately.
    vf_m = @(v)(isnumeric(v) && isreal(v) && is1or2(numel(v)) && isintvalue(v) && ispos(v));
    addOptional(pp, 'm', defaults.m, vf_m);
    
    % Argument "n" (tile width, number of columns per tile)
    vf_n = @(v)(isnumeric(v) && isreal(v) && is0or1(numel(v)) && isintvalue(v) && ispos(v));
    addOptional(pp, 'n', defaults.n, vf_n);
    
    % Argument "TileOrder"
    vf_tileorder = @(v)(ischar(v) && isvector(v) && istileordervalue(v));
    addParameter(pp, 'TileOrder', defaults.TileOrder, vf_tileorder);
    
    % Argument "Postproc"
    vf_postprocname = @(v)(~isempty(v) && ischarvec(v) && isfunc(BuiltinPostprocs(v)));
    vf_postproc = @(v)(isempty(v) || isfunc(v) || vf_postprocname(v));
    addParameter(pp, 'Postproc', defaults.Postproc, vf_postproc);
    
    % Apply input parser
    parse(pp, varargin{:});
    args = pp.Results;
    
    % Post-processing on tile size (m, n)
    count_mn = numel(args.m) + numel(args.n);
    if ~is1or2(count_mn)
        error('Input m and n must specify tile height and width respectively.');
    end
    if count_mn == 1
        args.n = args.m;
    elseif numel(args.m) == 2
        args.n = args.m(2);
        args.m = args.m(1);
    end
    
    % Convert "TileOrder" into an integer
    % 0 : default or column or columnmajor
    % 1 : row or rowmajor
    % -1 : (invalid string)
    args.TileOrder = ParseTileOrder(args.TileOrder);
    
    % If "Postproc" is a name (string), convert it into a function.
    if vf_postprocname(args.Postproc)
        args.Postproc = BuiltinPostprocs(args.Postproc);
    end
end
