function imgout = ApplyPadding(imgin, args)
% If input image size is not evenly divisible by tile size, 
% apply padding.

    rows = args.rows;
    cols = args.cols;
    rowsUp = args.rowsUp;
    colsUp = args.colsUp;
    needPadding = (rows ~= rowsUp) || (cols ~= colsUp);
    if needPadding
        rowsPad = rowsUp - rows;
        colsPad = colsUp - cols;
        imgin = padarray(imgin, [rowsPad, colsPad], 'symmetric', 'post');
    end
    if nargout >= 1
        imgout = imgin;
    end
end
