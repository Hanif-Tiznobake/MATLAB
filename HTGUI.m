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
        
        function obj=SetLayout(obj,framecount)
            W=obj.host(1,1).Position(3);
            H=obj.host(1,1).Position(4);
            M=obj.state{3,2}.Margin;
            s=obj.state{3,2}.Spacing;
            t=5*M;
            nd=4;
            na=0;
            np=4;
            h=round(H/4);
            w=round(W/np);
            for i = 1:size(obj.components,1)
                if isa(obj.components(i,1),'HTPanel')
                    obj.components(i,1).Position=[i*M+(i-1)*w,M,w,h];
                end
            end
            obj.One.Position=[s,s,(obj.Group123.Position(3)-(nd+1)*s)/nd,...
                obj.Group123.Position(4)-2*s];
            obj.Two.Position=[sum(obj.One.Position([1,3]))+s,s,...
                (obj.Group123.Position(3)-(nd+1)*s)/nd,...
                obj.Group123.Position(4)-2*s];
            obj.Four.Position=[s,s,(obj.Group45.Position(3)-(na+1)*s)/na,...
                obj.Group45.Position(4)-2*s];
            obj.Five.Position=[sum(obj.Four.Position([1,3]))+s,s,...
                (obj.Group45.Position(3)-(na+1)*s)/na,...
                obj.Group45.Position(4)-2*s];
            set(obj.Group45,'Visible','on');
            if obj.state.LayoutMode==2
                set(obj.Group45,'Visible','off');
                if W>H
                    obj.Panel.Position=[w+2*M,M,W-w-3*M+1,H-2*M+1];
                    obj.Group123.Position=[M,h+2*M,w,H-h-3*M+1];
                    obj.Two.Position=[s,s,obj.Group123.Position(3)-2*s,...
                        (obj.Group123.Position(4)-(nd+1)*s)/nd];
                    obj.One.Position=[s,sum(obj.Two.Position([2,4]))+s,...
                        obj.Group123.Position(3)-2*s,...
                        (obj.Group123.Position(4)-(nd+1)*s)/nd];
                else
                    obj.Panel.Position=[M,h+2*M,W-2*M+1,H-h-3*M+1];
                end
            end
            n=framecount-1;
            if n>1
                a=[1,1,1;n^2,n,1;n*(n+1)*(2*n+1)/6,n*(n+1)/2,n]\[0.1;0.1;n];
                HT_Smooth=@(x,a) cumsum(a(1)*x.^2+a(2)*x+a(3));
            else
                a=[1,1,1];
                HT_Smooth=@(x,a) x;
            end
            m=length(activeAxes);
            l=length(activeMics);
            temp=obj.Graphics.Axis(activeAxes,activeMics)';
            Start=cat(1,temp.Position);
            End=repmat([t,t,obj.Panel.Position(3:4)-2*t],l*m,1);
            End(:,4)=(obj.Panel.Position(4)-(m+1)*t)/(l*m);
            m=1;
            l=1;
            for i=activeAxes
                for k=activeMics
                    End(l,2)=obj.Panel.Position(4)-l*End(l,4)-m*t;
                    l=l+1;
                end
                m=m+1;
            end
            Step=(End-Start)/n;
            if max(Step(:))<1
                n=1;
                Step=(End-Start)/n;
            end
            Path=(repmat(permute(Start,[3,2,1]),n,1,1)+...
                permute(Step,[3,2,1]).*HT_Smooth((1:n)',a));
            for i=inactiveAxes
                set([obj.Graphics.Axis(i,:);...
                    obj.Graphics.Axis(i,:).Children],'Visible','off');
            end
            set([reshape(obj.Graphics.Axis(:,inactiveMics),[],1);...
                cat(1,obj.Graphics.Axis(:,inactiveMics).Children)],...
                'Visible','off');
            set(obj.Graphics.Watermark,'Position',obj.Panel.Position);
            obj.Graphics.Credits=...
                Credits(obj.Graphics.Watermark,obj.Graphics.Color,false);
            for l=1:size(Path,1)
                j=1;
                for i=activeAxes
                    for k=activeMics
                        set(obj.Graphics.Axis(i,k),'Position',Path(l,:,j));
                        j=j+1;
                    end
                end
                drawnow;
            end
            for i=activeAxes
                set([obj.Graphics.Axis(i,activeMics);...
                    obj.Graphics.Axis(i,activeMics).Children],'Visible','on');
            end
        end
        
    end
end

