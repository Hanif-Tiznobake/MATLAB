classdef HTComponent < matlab.mixin.SetGet
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        host
        state
        count
    end
    
    methods
        function obj = HTComponent(state)
            obj=obj@matlab.mixin.SetGet;
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
        
        function value=GetProp(obj,host,prop)
            flag=false;
            for i = 1:size(obj.state{1,2},1)
                if strcmp(obj.state{1,2}{i,1},host)
                    flag=true;
                    for j = 1:size(obj.state{1,2}{i,2},1)
                        if strcmp(obj.state{1,2}{i,2}{j,1},prop)
                            value=obj.state{1,2}{i,2}{j,2};
                            break
                        end
                    end
                end
                if flag
                    break
                end
            end
        end
        
        function SetProp(obj,host,prop,value)
            flag=false;
            for i = 1:size(obj.state{1,2},1)
                if strcmp(obj.state{1,2}{i,1},host)
                    flag=true;
                    for j = 1:size(obj.state{1,2}{i,2},1)
                        if strcmp(obj.state{1,2}{i,2}{j,1},prop)
                            obj.state{1,2}{i,2}{j,2}=value;
                            break
                        end
                    end
                    
                end
                if flag
                    break
                end
            end
        end
    end
end

