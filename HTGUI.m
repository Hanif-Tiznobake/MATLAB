classdef HTGUI < HTComponent
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        components
    end
    
    methods
        function obj = HTGUI(state)
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
            obj=obj@HTComponent(state);
            obj.host(1,1)=uifigure();
            obj.host(2,1)=uitabgroup(obj.host(1,1));
            obj.components=HTComponent.empty;
            for i = 1:obj.count
                switch lower(state{2,2}{i,1})
                    case 'httab'
                        obj.components(i,1) = HTTab(obj.host(2,1),obj.state{2,2}{i,2});
                    case 'htpanel'
                        obj.components(i,1) = HTPanel(obj.host(1,1),obj.state{2,2}{i,2});
                end
                obj.components(i,1).SetProps(obj.state{2,2}{i,2}{1,2});
            end
            obj.SetProps(obj.state{1,2});
        end
        
    end
end

