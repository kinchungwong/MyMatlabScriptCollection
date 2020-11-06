function func = BuiltinPostprocs(name)
    name = lower(name);
    switch name
        case { 'smooth', 'gaussian', 'imgaussfilt3' }
            func = @(img)(imgaussfilt3(img, [1.0, 1.0, 1.0]));
        otherwise
            func = [];
    end
end
