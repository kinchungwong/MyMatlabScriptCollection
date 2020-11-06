function imgout = ApplySort(imgin, args)
% Sort the samples within each tile. Each of the R, G, B channels are
% processed separately.

    % args is currently unused; 
    % usage might be needed in the future.
    [~] = args; 
    
    imgin = sort(imgin, 1, 'ascend');

    if nargout >= 1
        imgout = imgin;
    end
end
