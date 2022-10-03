function [W,V,M,PCAtrain]=FLDA(X)
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