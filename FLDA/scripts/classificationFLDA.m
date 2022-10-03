X=cell(1,65);
for i=1:65
    data=[];
    for j=[7,10,19]
        img=imread(sprintf('.\\PIE_Nolight\\%d\\%d.bmp',i,j));
        img=im2double(img);
        data=[data img(:)];
    end
    X{i}=data;
end
[W,V,M]=FLDA(X);

projects=zeros(64,65,21);
for i=1:65
    for j=1:21
        img=imread(sprintf('.\\PIE_Nolight\\%d\\%d.bmp',i,j));
        img=im2double(img);
        projects(:,i,j)=W'*V'*(img(:)-M);
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
fprintf('The overall recognition rate with FLDA is %3.1f%%\n',recogCount/11.7);

function [W,V,M]=FLDA(X)
    train=[];
    for i=1:65
        train=[train X{i}];
    end
    M=mean(train,2);
    C=train-M;
    G=C'*C;
    [u D]=eig(G);
    V=C*u;
    for i=1:195
        V(:,i)=V(:,i)/norm(V(:,i));
    end
    [D,idx]=sort(diag(D),'descend');
    V=V(:,idx);
    V=V(:,1:130);
    PCAtrain=cell(1,65);
    for i=1:65
        data=[];
        for j=1:3
            data=[data V'*(X{i}(:,j)-M)];
        end
        PCAtrain{i}=data;
    end
    m=[];
    for i=1:65
        m=[m mean(PCAtrain{i},2)];
    end
    SB=(m-mean(m,2))*(m-mean(m,2))';
    SW=zeros(130,130);
    for i=1:65
        SW=SW+(PCAtrain{i}-m(:,i))*(PCAtrain{i}-m(:,i))';
    end
    [W D]=eig(SB,SW);
    [D,idx]=sort(diag(D),'descend');
    W=W(:,idx);
    W=W(:,1:64);
end