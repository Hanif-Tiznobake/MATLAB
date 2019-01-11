classdef HTGUI < HTComponent
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tabgroup
        components
    end
    
    methods
        function obj = HTGUI(state)
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
            obj=obj@HTComponent(state);
            obj.host=uifigure();
            obj.tabgroup=uitabgroup(obj.host);
            obj.components=HTComponent.empty(obj.count,0);
            for i = 1:obj.count
                switch lower(state{2,2}{i,1})
                    case 'httab'
                        obj.components(i,1) = HTTab(obj.tabgroup,obj.state{2,2}{i,2});
                    case 'htpanel'
                        obj.components(i,1) = HTPanel(obj.host,obj.state{2,2}{i,2});
                end
                obj.components(i,1).SetProps(obj.state{2,2}{i,2}{1,2});
            end
            for i =1:size(state{1,2}{1,2},1)
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

