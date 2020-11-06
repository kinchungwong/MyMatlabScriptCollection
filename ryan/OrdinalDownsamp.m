function [imgout, args] = OrdinalDownsamp(imgin, varargin)
%
% OrdinalDownsamp
% Author: Kinchung (Ryan) Wong
%
% Package namespace: "ryan.OrdinalDownsamp"
%
% License type: MIT License
%

    % Import functions from package
    ParseArgs = @ordinal_downsamp.ParseArgs;
    ParseImageInfo = @ordinal_downsamp.ParseImageInfo;
    ApplyPadding = @ordinal_downsamp.ApplyPadding;
    PreShape = @ordinal_downsamp.PreShape;
    ApplySort = @ordinal_downsamp.ApplySort;
    ApplyPostproc = @ordinal_downsamp.ApplyPostproc;
    PostShape = @ordinal_downsamp.PostShape;
    RemovePadding = @ordinal_downsamp.RemovePadding;

    % Parse input arguments
    args = ParseArgs(varargin{:});
    
    % Compute image parameters
    % (also compute downsampling, upsampling, and padding parameters)
    args = ParseImageInfo(imgin, args);

    % If input image size is not evenly divisible by tile size, 
    % apply padding.
    imgin = ApplyPadding(imgin, args);
    
    % Reshapes and permutes the data dimensions so that the pixels from each
    % tile is contiguously laid out in the array as well as in memory space.
    imgin = PreShape(imgin, args);

    % Sort the samples within each tile. Each of the R, G, B channels are
    % processed separately.
    imgin = ApplySort(imgin, args);

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
    imgin = ApplyPostproc(imgin, args);
        
    % Reverts the reshape and permutation of data dimension, in order
    % to present the output in a layout suitable for human visualization.
    imgin = PostShape(imgin, args);
    
    % Remove the padding that was added to make the image size evenly 
    % divisible by tile size.
    imgin = RemovePadding(imgin, args);
    
    % Assign output.
    if nargout >= 1
        imgout = imgin;
    end
end
