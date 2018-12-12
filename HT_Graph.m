classdef HT_Axis < axes
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        graphs
        count
    end
    
    methods
        function obj = HT_Axis(panel, props, graphs)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj = obj@axes(panel,'Box','on');
            set(obj,'NextPlot','add');
            obj.count=size(graphs,1);
            for i = 1:obj.count
                switch lower(graphs{i,1})
                    case 'plot'
                        obj.graphs(i) = plot(axis,NaN(1,2),NaN(1,2));
                    case 'scatter'
                        obj.graphs(i) = scatter(axis,NaN(1,2),NaN(1,2));
                    case 'surf'
                        obj.graphs(i) = surf(axis,NaN(1,2),NaN(1,2),NaN(2,2));
                    case 'patch'
                        obj.graphs(i) = fill(axis,NaN,NaN);
                    case 'line'
                        obj.graphs(i) = line(axis,NaN(1,2),NaN(1,2),NaN(1,2));
                end
                for j=1:size(graphs{i,2},1)
                    set(obj.graphs(i),graphs{i,2}{j,1},graphs{i,2}{j,2});
                end
            end
            for i =1:size(props,1)
                set(obj,props{i,2}{j,1},props{i,2}{j,2});
            end
            set(obj,'NextPlot','replacechildren');
        end
         
        
        function clear(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            for i = 1:obj.count
                set(obj.graphs(i),  'XData',NaN(size(obj.graphs(i).XData)),...
                                    'YData',NaN(size(obj.graphs(i).YData)),...
                                    'ZData',NaN(size(obj.graphs(i).ZData)));
            end
        end
    end
end