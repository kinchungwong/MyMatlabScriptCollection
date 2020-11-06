function imgout = RemovePadding(imgin, args)
% Remove the padding that was added to make the image size evenly 
% divisible by tile size.

    rows = args.rows;
    cols = args.cols;
    rowsUp = args.rowsUp;
    colsUp = args.colsUp;

    if rows ~= rowsUp || cols ~= colsUp
        imgin = imgin(1:rows, 1:cols, :);
    end

    if nargout >= 1
        imgout = imgin;
    end
end
