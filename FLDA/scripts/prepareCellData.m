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