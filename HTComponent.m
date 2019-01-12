classdef HTComponent < matlab.mixin.Heterogeneous
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        host
        state
        count
    end
    
    methods
        function obj = HTComponent(state)
            obj.host=gobjects;
            obj.state=state;
            obj.count=size(obj.state{2,2},1);
        end
        
        function SetProps(obj,props)
            for i = 1:size(obj.host,1)
                for j = 1:size(props{i,2},1)
                    set(obj.host(i,1),props{i,2}{j,1},props{i,2}{j,2});
                end
            end
        end
        
        function value=GetProp(obj,prop)
            for i = 1:size(obj.state{1,2},1)
                if strcmp(obj.state{1,2}{i,1},prop)
                    value=obj.state{1,2}{i,2};
                    break
                end
            end
        end
        
    end
end

