function imgout = ApplyPostproc(imgin, args)
% Apply post-processing function, if specified.
%
% An example of post-processing function is the MATLAB command
% IMGAUSSFILT3.
%
% The post-processing function will be passed a three-dimensional
% array.
%
% The first two dimensions will be rows (one for each row of tile)
% and columns (one for each column of tile).
%
% The third dimension will be the order-statistic dimension,
% where (TR, TC, 1) will contain the minimum value extracted from
% the input tile (at the tile row TR and the tile column TC);
% where (TR, TC, end) will contain the maximum value extracted.
%
% Each of the R, G, B channels are processed separately. 
% Therefore, the post-processing function will be called as many 
% times as there are image channels.
%
    
    if ~isa(args.Postproc, 'function_handle') || isempty(args.Postproc)
        if nargout >= 1
            imgout = imgin;
        end
        return;
    end
    
    chans = args.chans;
    Postproc = args.Postproc;
    
    %
    % Remark ... 
    % Prior to calling this function, the image would have been transformed
    % as follows:
    % imgin = reshape(imgin, m * n, rowsDn, colsDn, chans);
    % imgin = sort(imgin, 1, 'ascend');
    %
    for kchan = 1:chans
        imgslice = imgin(:, :, :, kchan);
        imgslice = permute(imgslice, [2, 3, 1]);
        imgslice = Postproc(imgslice);
        imgslice = permute(imgslice, [3, 1, 2]);
        imgin(:, :, :, kchan) = imgslice;
    end
    if nargout >= 1
        imgout = imgin;
    end
end
