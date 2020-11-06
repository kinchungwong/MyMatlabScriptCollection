function args = ParseImageInfo(imgin, args)
% Compute image parameters
% (also compute downsampling, upsampling, and padding parameters)

    [rows, cols, chans] = size(imgin);
    args.rows = rows;
    args.cols = cols;
    args.chans = chans;
    if isfield(args, 'm') && isfield(args, 'n')
        m = args.m;
        n = args.m;
        args.rowsDn = ceil(rows / m);
        args.colsDn = ceil(cols / n);
        args.rowsUp = args.rowsDn * m;
        args.colsUp = args.colsDn * n;
    end
end
