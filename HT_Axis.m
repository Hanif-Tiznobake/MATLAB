classdef HT_Axis
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        axis
        graphs
        count
    end
    
    methods
        function obj = HT_Axis(parent, state)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.axis = axes(parent,'Box','on');
            set(obj.axis,'NextPlot','add');
            obj.count=size(state.graphs,1);
            obj.graphs=gobjects(obj.count,1);
            for i = 1:obj.count
                switch lower(state.graphs{i,1})
                    case 'plot'
                        obj.graphs(i) = plot(obj.axis,NaN,NaN);
                    case 'scatter'
                        obj.graphs(i) = scatter(obj.axis,NaN,NaN);
                    case 'surf'
                        obj.graphs(i) = surf(obj.axis,[NaN,NaN],[NaN,NaN],[NaN,NaN;NaN,NaN]);
                    case 'patch'
                        obj.graphs(i) = fill(obj.axis,NaN,NaN,[0,0,0]);
                    case 'line'
                        obj.graphs(i) = line(obj.axis);
                end
                for j=1:size(state.graphs{i,2},1)
                    set(obj.graphs(i),state.graphs{i,2}{j,1},state.graphs{i,2}{j,2});
                end
            end
            for i =1:size(state.properties,1)
                set(obj.axis,state.properties{i,1},state.properties{i,2});
            end
            set(obj.axis,'NextPlot','replacechildren');
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