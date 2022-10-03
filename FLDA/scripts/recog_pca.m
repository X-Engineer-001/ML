data=zeros(10000,65,21);
for i=1:65
    for j=1:21
        img=imread(sprintf('.\\PIE_Nolight\\%d\\%d.bmp',i,j));
        img=im2double(img);
        data(:,i,j)=img(:);
    end
end
train=[];
for i=1:65
    for j=[7,10,19]
        train=[train data(:,i,j)];
    end
end
m=mean(train,2);
X=train-m;
G=X'*X;
[u D]=eigs(G,194,'largestreal');
v=X*u;
for i=1:194
    v(:,i)=v(:,i)/norm(v(:,i));
end
[D,idx]=sort(diag(D),'descend');
v=v(:,idx);
projects=zeros(194,65,21);
for i=1:65
    for j=1:21
        projects(:,i,j)=v(:,1:194)'*(data(:,i,j)-m);
    end
end
recogLabels=zeros(65,21);
recogCount=0;
for i=1:65
    for j=[1:6,8:9,11:18,20:21]
        minD=Inf;
        label=0;
        for c=1:65
            for t=[7,10,19]
                d=norm(projects(:,i,j)-projects(:,c,t));
                if d<minD
                    minD=d;
                    label=c;
                end
            end
        end
        recogLabels(i,j)=label;
        %fprintf('pid(truth): %d, image: %d, label: %d\n',i,j,label);
        if i==label
            recogCount=recogCount+1;
        end
    end
end
fprintf('Recognition rate = %3.1f%%\n',recogCount/11.7);