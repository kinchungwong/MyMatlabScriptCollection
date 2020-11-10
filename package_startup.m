% The startup script makes use of .NET functionality.
NET.addAssembly('System.IO');

fprintf('\nInitializing MyMatlabScriptCollection (mmsc)\n\n');

mmsc.user_path = userpath;
mmsc.local_git_path = fullfile(userpath, 'MyMatlabScriptCollection');
mmsc.local_shadow_path = fullfile(userpath, 'mmsc_shadow');
mmsc.package_list_file = fullfile(mmsc.local_git_path, 'package_list.csv');

fprintf('Local git repository for mmsc: %s\n', mmsc.local_git_path);
fprintf('MATLAB shadow search path for mmsc: %s\n', mmsc.local_shadow_path);
fprintf('Package list file: %s\n', mmsc.package_list_file);

fprintf('\n');

if isfolder(mmsc.local_git_path)
    if ~isfolder(mmsc.local_shadow_path)
        mkdir(mmsc.local_shadow_path)
    end
    addpath(mmsc.local_shadow_path, '-end');
    if isfile(mmsc.package_list_file)
        mmsc.package_list = System.IO.File.ReadAllLines(mmsc.package_list_file);
        mmsc.package_list = string(mmsc.package_list);
        mmsc.package_list = cellfun(@strtrim, mmsc.package_list, 'UniformOutput', false);
        % This loop is only for producing diagnostic messages, before the lines are filtered.
        for mmsc_package_item_name = mmsc.package_list
            clear mmsc_package_item
            mmsc_package_item.name = char(mmsc_package_item_name);
            if isempty(mmsc_package_item.name)
                continue;
            end
            if mmsc_package_item.name(1) == '%'
                continue;
            end
            if ~isvarname(mmsc_package_item.name)
                warning('Package item name invalid; not added to shadow search path. %s', mmsc_package_item.name);
                continue;
            end
        end
        % Remove lines of text from package_list if they are not valid package name.
        mmsc.package_list = mmsc.package_list(cellfun(@isvarname, mmsc.package_list));
        % This loop creates the directory junctions for each package.
        for mmsc_package_item_name = mmsc.package_list
            clear mmsc_package_item
            mmsc_package_item.name = char(mmsc_package_item_name);
            mmsc_package_item.name_in_shadow = strcat('+', mmsc_package_item.name);
            mmsc_package_item.path_in_git = fullfile(mmsc.local_git_path, mmsc_package_item.name);
            mmsc_package_item.path_in_shadow = fullfile(mmsc.local_shadow_path, mmsc_package_item.name_in_shadow);
            mmsc_package_item.exists_in_git = isfolder(mmsc_package_item.path_in_git);
            mmsc_package_item.exists_in_shadow = isfolder(mmsc_package_item.path_in_shadow);
            if ~mmsc_package_item.exists_in_git
                fprintf('Package list contains %s, but directory not found. %s\n', mmsc_package_item.name, mmsc_package_item.path_in_git);
            else
                fprintf('Found mmsc package %s\n', mmsc_package_item.name);
                if ~mmsc_package_item.exists_in_shadow
                    mmsc_package_item.mklink_cmd = sprintf('mklink /J %s %s', mmsc_package_item.path_in_shadow, mmsc_package_item.path_in_git);
                    fprintf('%s\n', mmsc_package_item.mklink_cmd);
                    system(mmsc_package_item.mklink_cmd);
                end
                if ~isfolder(mmsc_package_item.path_in_shadow)
                    fprintf('Unable to create shadow folder: %s\n');
                end
            end
            clear mmsc_package_item
        end
        clear mmsc_package_item_name
    end
end

fprintf('\nFinished initializing MyMatlabScriptCollection (mmsc)\n\n');
