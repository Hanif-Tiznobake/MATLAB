classdef HT_Panel
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        panel
        components
        count
    end
    
    methods
        function obj = HT_Panel(parent, state)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.panel=uipanel(parent);
            obj.count=size(state.components,1);
            obj.components=gobjects(obj.count,1);
            for i = 1:obj.count
                switch lower(state.components{i,1})
                    case 'dropdown'
                        obj.components(i) = uidropdown(obj.panel);
                    case 'listbox'
                        obj.components(i) = uilistbox(obj.panel);
                    case 'modify'
                        obj.components(i) = uislider(obj.panel);
                end
                for j=1:size(state.components{i,2},1)
                    set(obj.components(i),state.components{i,2}{j,1},state.components{i,2}{j,2});
                end
            end
            for i =1:size(state.properties,1)
                set(obj.panel,state.properties{i,1},state.properties{i,2});
            end            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

