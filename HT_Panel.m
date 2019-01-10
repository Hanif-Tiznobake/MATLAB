classdef HT_Panel < matlab.ui.container.Panel
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dropdown
        listbox
        modify
    end
    
    methods
        function obj = HT_Panel(parent)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj=obj@matlab.ui.container.Panel(parent);
            obj.dropdown = uidropdown(obj,'Position',[25,135,120,25]);
            obj.listbox = uilistbox(obj,'Position',[25,10,120,125]);
            obj.modify = uislider(obj,'Position',[10,10,3,150]);
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

