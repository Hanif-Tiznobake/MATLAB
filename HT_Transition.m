function Object=HT_Transition(Object,Prop,Target,frames)
%HT_Transition Applies transitions on m in graphic objects.

%   Inputs:
%       Object: Matrix of graphic object(s).
%       Prop: Cell array of character vectors, containing names
%       of the transitioning J properties.
%       Target: Final Properties state.
%       frames: number of frames for transition.

% © 2018 Hanif Tiznobake

n=frames-1;
if n>1
    a=[1,1,1;n^2,n,1;n*(n+1)*(2*n+1)/6,n*(n+1)/2,n]\[0.1;0.1;n];
    Smooth=@(x,a) cumsum(a(1)*x.^2+a(2)*x+a(3));
else
    a=[1,1,1];
    Smooth=@(x,a) x;
end
steps=Smooth(1:n,a);
temp1=[];
[K,J]=size(Objects);
for k=1:K
    temp2=[];
    for j=1:J
        temp2=cat(2,temp2,Object(k,j).(Prop{j}));
    end
    temp1=cat(3,temp1,temp2);
end
Target=cat(1,temp1,repmat(Target,1,1,size(Object,1)));
path=zeros(n,size(Target,2),size(Target,3));
for j=1:size(path,2)
    for k=1:size(path,3)
        path(:,j,k)=(Target(1,j,k)+steps*(Target(2,j,k)-Target(1,j,k))/n)';
    end
end
for i=1:size(path,1)
    l=1;
    for j=1:length(Prop)
        for k=1:size(path,3)
            s=length(Object(k,j).(Prop{j}));
            Object(k,j).(Prop{j})=path(i,l:l+s-1);
        end
        l=l+s;
    end
    drawnow
    %     handles=HT_Record(handles,'all');
end
end

