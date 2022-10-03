function displayEigenface(pid)
    faces=zeros(10000,21);
    for i=1:21
        img=imread(sprintf('.\\PIE_Nolight\\%d\\%d.bmp',pid,i));
        img=im2double(img);
        faces(:,i)=img(:);
    end
    m=mean(faces,2);
    X=faces-m;
    G=X'*X;
    [u D]=eig(G);
    v=X*u;
    for i=1:21
        v(:,i)=v(:,i)/norm(v(:,i));
    end
    [D,idx]=sort(diag(D),'descend');
    v=v(:,idx);
    subplot(6,4,1);
    sub=reshape(m,[100,100]);
    imagesc(sub);
    colormap gray;
    title('mean');
    for i=1:21
        subplot(6,4,i+1);
        sub=reshape(v(:,i),[100,100]);
        imagesc(sub);
        colormap gray;
        title(sprintf('eigenface %d',i));
    end
end