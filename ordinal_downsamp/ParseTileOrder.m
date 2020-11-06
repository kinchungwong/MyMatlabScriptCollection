function n = ParseTileOrder(strTileOrder)
    strTileOrder = lower(strTileOrder);
    switch strTileOrder 
        case { 'default', 'c', 'column', 'columnmajor' }
            n = 0;
        case { 'r', 'row', 'rowmajor' }
            n = 1;
        otherwise
            n = -1;
    end
end
