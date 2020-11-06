function imgout = PostShape(imgin, args)
% Reverts the reshape and permutation of data dimension, in order
% to present the output in a layout suitable for human visualization.

    chans = args.chans;
    m = args.m;
    n = args.m;
    TileOrder = args.TileOrder;
    rowsDn = args.rowsDn;
    colsDn = args.colsDn;
    rowsUp = args.rowsUp;
    colsUp = args.colsUp;

    imgin = reshape(imgin, m, n, rowsDn, colsDn, chans);
    if TileOrder == 0
        imgin = permute(imgin, [1, 3, 2, 4, 5]);
    else
        imgin = permute(imgin, [2, 3, 1, 4, 5]);
    end
    imgin = reshape(imgin, rowsUp, colsUp, chans);

    if nargout >= 1
        imgout = imgin;
    end
end
