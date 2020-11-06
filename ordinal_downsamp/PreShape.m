function imgout = PreShape(imgin, args)
% Reshapes and permutes the data dimensions so that the pixels from each
% tile is contiguously laid out in the array as well as in memory space.
%
% This step is done to facilitate the pixel sample sorting step.
%

    m = args.m;
    n = args.m;
    chans = args.chans;
    rowsDn = args.rowsDn;
    colsDn = args.colsDn;
    
    imgin = reshape(imgin, m, rowsDn, n, colsDn, chans);
    imgin = permute(imgin, [1, 3, 2, 4, 5]);
    imgin = reshape(imgin, m * n, rowsDn, colsDn, chans);
    
    if nargout >= 1
        imgout = imgin;
    end
end
