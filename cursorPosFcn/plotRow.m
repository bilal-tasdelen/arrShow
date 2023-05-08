function plotRow(asObj, pos)

% get selected image from asObj
currImg = squeeze(asObj.getSelectedImages(false));

% assure that its a single 2D image
si = size(currImg);
if numel(si) ~= 2 || si(2) == 1
    fprintf('Only single two-dimensional images or single row vectors are currently supported by plotRow\n');
    if isvalid(asObj)
        asObj.cursor.togglePlotRowAndCol(false)
    end
    return
end

% if this is the first call...
if isempty(asObj.UserData) ||...
        ~isfield(asObj.UserData,'plotRowFigHandle') ||...
        ~ishandle(asObj.UserData.plotRowFigHandle)||...
        ~strcmp(get(asObj.UserData.plotRowFigHandle,'Tag'),'asPlotFig')
    
    % create plot window
    asObj.UserData.plotRowFigHandle = figure(...
        'MenuBar','figure',...
        'name',['Row-Plot: ',asObj.getFigureTitle],...
        'ToolBar','none',...
        'Tag','asPlotFig',...
        'IntegerHandle','off');    
    
    % create subplots for row and column  
    asObj.UserData.rowOnlyPlotHandle = axes('parent',asObj.UserData.plotRowFigHandle);
end

% figure;
cPlot(1:size(currImg,2), currImg(pos(1),:)', 'parent', asObj.UserData.rowOnlyPlotHandle);

% create plot title
title(asObj.UserData.rowOnlyPlotHandle, ['Row ', num2str(pos(1))]);

% create plot figure title
set(asObj.UserData.plotRowFigHandle,'name',['Row-Plot: ',asObj.getFigureTitle()]);

end
