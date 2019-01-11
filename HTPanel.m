classdef HTPanel < HTComponent
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        components
    end
    
    methods
        function obj = HTPanel(parent, state)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj=obj@HTComponent(state);
            obj.host=uipanel(parent);
            obj.components=gobjects(obj.count,1);
            for i = 1:obj.count
                switch lower(obj.state{2,2}{i,1})
                    case 'dropdown'
                        obj.components(i,1) = uidropdown(obj.host);
                    case 'listbox'
                        obj.components(i,1) = uilistbox(obj.host);
                    case 'modify'
                        obj.components(i,1) = uislider(obj.host);
                end
                for j=1:size(obj.state{2,2}{i,2}{1,2},1)
                    set(obj.components(i,1),obj.state{2,2}{i,2}{1,2}{j,1},obj.state{2,2}{i,2}{1,2}{j,2});
                end
            end
            for i =1:size(obj.state{1,2}{1,2},1)
                set(obj.host,obj.state{1,2}{1,2}{i,1},obj.state{1,2}{1,2}{i,2});
            end            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

