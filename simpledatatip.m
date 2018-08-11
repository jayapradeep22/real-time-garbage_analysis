function eg = simpledatatip()
clf;
s = load('LocationData.mat'); % loading dataset
[m,n] = size(s.Data001); % saving the dimensions of the data into m,n
  dcount=0; %counter variables for the loop
  dindex=1; % counter variables for the loop
  totalWaste_77058=0;
  totalWaste_77062=0;
for c=dindex:m %looping through the dataset to map latitude and longitudes into map
   line(s.Data001(dindex, 1), s.Data001(dindex, 2), 'Marker', 'o', ...
    'Color', 'b', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
if s.Data001(dindex, 4) ==77058
totalWaste_77058 = totalWaste_77058+ s.Data001(dindex, 3);
else
    totalWaste_77062 = totalWaste_77062+ s.Data001(dindex, 3); 
end
dindex=dindex+1;

end

plotting =plot_google_map('maptype', 'roadmap');
    hTarget = handle(plotting);
    xdata = get(hTarget,'XData') ;
    ydata = get(hTarget,'YData') ;
    mindex=1;
    xlocation_events=[];
     ylocation_events=[];
    for c=mindex:m
        [~,locx]=min(abs(xdata-s.Data001(mindex, 1)));
        [~,locy]=min(abs(ydata-s.Data001(mindex, 2)));
          xlocation_events(end+1) = locx; %saving index of the locations from x-axis using matrix linear indexing
           ylocation_events(end+1) = locy;
          mindex =mindex+1;
    end
    disp(ylocation_events);
    dtip = add_datatips( xlocation_events ,ylocation_events, hTarget);
function hdtip = add_datatips( xevt_times ,yevt_times, hTarget )
    %// retrieve the datacursor manager
    cursorMode = datacursormode(figure);
    set(cursorMode, 'enable','on', 'UpdateFcn',@customDatatipFunction);
    
    %set(cursorMode, 'UpdateFcn',@customDatatipFunction, 'NewDataCursorOnClick',false);
    xdata = get(hTarget,'XData') ;
    ydata = get(hTarget,'YData') ;


    %// add the datatip for each event
   
    for idt = 1:numel(xevt_times)
        hdtip(idt) = cursorMode.createDatatip(hTarget) ;
        set(hdtip(idt), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');

        %// move it into the right place
        
        idx = xevt_times(idt) ;%// find the index of the corresponding time
        idy= yevt_times(idt);
        pos = [xdata(idx) , ydata(idy) ,1 ];
        set(hdtip(idt), 'Position', pos);
       
        updateDataCursors(cursorMode)
       
       % update(hdtip(idt), pos);
    end
end
 counterWaste=1;
 %Calculating waste and plotting on the map
function output_txt = customDatatipFunction(~,evt)
    
    pos = get(evt,'Position');
    idx = get(evt,'DataIndex');
    output_txt = { ...
        '*** !! Location Details !! ***' , ...
        ['Lon: '  num2str(pos(1),4)] ...
        ['Lat: '   , num2str(pos(2),8)] ...
        ['Waste(in pounds: ',num2str(s.Data001(counterWaste, 3))] ...
                };
             counterWaste = counterWaste+1;          
end
end

 